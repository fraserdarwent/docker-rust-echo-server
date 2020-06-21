FROM clux/muslrust:stable AS build
WORKDIR /src
COPY /Cargo.toml .
COPY /Cargo.lock .
COPY /src ./src
RUN cargo build --target x86_64-unknown-linux-musl --release
RUN useradd docker-echo-server

FROM scratch
COPY --from=build /src/target/x86_64-unknown-linux-musl/release/docker-rust-echo-server /
COPY --from=build /etc/passwd /etc/passwd
USER docker-echo-server
ENTRYPOINT ["/docker-rust-echo-server"]