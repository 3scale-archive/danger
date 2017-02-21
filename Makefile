IMAGE_NAME ?= danger
VOLUME = -v $(PWD):/src/ -w /src/
DANGER_ENV = DANGER_GITHUB_API_TOKEN
TRAVIS_ENV = HAS_JOSH_K_SEAL_OF_APPROVAL TRAVIS_PULL_REQUEST TRAVIS_REPO_SLUG TRAVIS_PULL_REQUEST
DOCKER_ENV += $(TRAVIS_ENV)
DOCKER_ENV += $(DANGER_ENV)
ENV = $(addprefix --env ,$(foreach env,$(DOCKER_ENV),$(env)=$(shell echo $$$(env))))

build:
	docker build -t $(IMAGE_NAME) .
test:
	docker run $(VOLUME) $(ENV) -u root $(IMAGE_NAME) danger
local:
	docker run $(VOLUME) $(IMAGE_NAME) danger local
bash:
	docker run -it $(VOLUME) $(IMAGE_NAME) bash
