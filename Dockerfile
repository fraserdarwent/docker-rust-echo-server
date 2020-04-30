FROM clux/muslrust:stable AS build
WORKDIR /src
COPY /Cargo.toml .
COPY /Cargo.lock .
COPY /src ./src
RUN cargo build --target x86_64-unknown-linux-musl --release

FROM scratch
WORKDIR /
COPY --from=build /src/target/x86_64-unknown-linux-musl/release/docker-rust-echo-server .
ENTRYPOINT ["/docker-rust-echo-server"]