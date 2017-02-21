TAG ?= $(firstword $(TRAVIS_TAG) $(TRAVIS_BRANCH) latest)
IMAGE_NAME ?= danger:$(TAG)
REGISTRY ?= quay.io/3scale
REMOTE_IMAGE_NAME = $(REGISTRY)/$(IMAGE_NAME)

VOLUME = -v $(PWD):/src/ -w /src/

DANGER_ENV = DANGER_GITHUB_API_TOKEN
TRAVIS_ENV = HAS_JOSH_K_SEAL_OF_APPROVAL TRAVIS_PULL_REQUEST TRAVIS_REPO_SLUG TRAVIS_PULL_REQUEST
DOCKER_ENV += $(TRAVIS_ENV)
DOCKER_ENV += $(DANGER_ENV)
ENV = $(addprefix --env ,$(foreach env,$(DOCKER_ENV),$(env)=$(shell echo $$$(env))))

build:
	docker build -t $(IMAGE_NAME) .
test:
	docker run $(VOLUME) $(ENV) -u $(shell id -u) $(IMAGE_NAME) danger
local:
	docker run $(VOLUME) $(IMAGE_NAME) danger local
bash:
	docker run -it $(VOLUME) $(IMAGE_NAME) bash

push:
	docker tag $(IMAGE_NAME) $(REMOTE_IMAGE_NAME)
	docker push $(REMOTE_IMAGE_NAME)
