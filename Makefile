version=1.0.0
docker-latest:
	docker build . -t fraserdarwent/echo:latest
docker-versioned: docker-latest
	docker tag fraserdarwent/echo:latest fraserdarwent/echo:$(version)
release: docker-versioned
	docker push fraserdarwent/echo:latest
	docker push fraserdarwent/echo:$(version)