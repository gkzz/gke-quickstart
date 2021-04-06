.DEFAULT_GOAL := help
CONTAINER_NAME := hello-python
PROJECT_ID:= $(shell gcloud config list project --format="value(core.project)")
COMMIT_HASH := $(shell git rev-parse --short HEAD)
## -- Section Delimiter --
## Ref: Add a help target to a Makefile that will allow all targets to be self documenting
## https://gist.github.com/prwhite/8168133
## This help message
## Which can also be multiline

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## make build
	docker build -f Dockerfile -t gcr.io/${PROJECT_ID}/${CONTAINER_NAME}:${COMMIT_HASH} .
	#docker build -f Dockerfile -t gcr.io/$(PROJECT_ID)/$(CONTAINER_NAME):single .
	#docker build -f Dockerfile -t gcr.io/$(PROJECT_ID)/$(CONTAINER_NAME):multistage2 .

.PHONY: image
image: ## make image
	#docker image ls ${PROJECT_ID}
	docker image ls | grep ${CONTAINER_NAME}

.PHONY: run
run: ## make run
	#docker run -d -p 80:80 --name ${CONTAINER_NAME}-v0 -v ${PWD}/app:/app gcr.io/${PROJECT_ID}/${CONTAINER_NAME}:v0
	docker run -d -p 80:80 --name ${CONTAINER_NAME}-${COMMIT_HASH} -v ${PWD}/app:/app gcr.io/${PROJECT_ID}/${CONTAINER_NAME}:${COMMIT_HASH}

.PHONY: push
push: ## make push
	docker push gcr.io/${PROJECT_ID}/${CONTAINER_NAME}:${COMMIT_HASH}
	#docker push gcr.io/${PROJECT_ID}/${CONTAINER_NAME}:v0

.PHONY: ps
ps: ## make ps
	docker ps -a | grep "${CONTAINER_NAME}" | head -n 1

.PHONY: rm
rm: ## make rm
	docker rm -f $$(docker ps -a | grep "${CONTAINER_NAME}" | head -n 1 | awk '{print $$1}')

.PHONY: rmall
rmall: ## make rmall
	docker ps -a | grep -E "${CONTAINER_NAME}" | awk '{print $$1}' | xargs docker rm -f

.PHONY: logs
logs: ## make logs
	docker logs ${CONTAINER_NAME}-${COMMIT_HASH}

.PHONY: exec
exec: ## make exec
	docker exec -it ${CONTAINER_NAME}-${COMMIT_HASH} /bin/bash
	#docker exec -it ${CONTAINER_NAME}-v0 /bin/bash

.PHONY: pytest
pytest: ## make pytest
	docker exec ${CONTAINER_NAME}-${COMMIT_HASH} /bin/bash -c 'pytest -v --cov=tests --cov-report=html'
	#docker exec ${CONTAINER_NAME}-v0 /bin/bash -c 'pytest --cov=tests'