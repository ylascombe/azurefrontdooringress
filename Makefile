.PHONY: dependencies test integration checks publish

all: dependencies test build docker

dependencies:
	dep ensure -v --vendor-only

test:
	go test -short ./...

integration:
	bash -f ./scripts/clustertestsetup.sh
	go test -v -timeout 5m ./...

build:
	go build .

checks:
	golangci-lint run ./...

docker:
	docker build -t kristoyoyo/azurefrontdoor-ingress:v0.0.2 .

publish:
	docker image push kristoyoyo/azurefrontdoor-ingress:v0.0.2