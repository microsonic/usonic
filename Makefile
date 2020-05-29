ifndef DOCKER_CMD
    DOCKER_CMD=bash
endif

ifndef USONIC_IMAGE_TAG
    USONIC_IMAGE_TAG=latest
endif

ifndef USONIC_RUN_IMAGE
    USONIC_RUN_IMAGE=usonic
endif

ifndef USONIC_DEBUG_IMAGE
    USONIC_DEBUG_IMAGE=usonic-debug
endif

ifndef USONIC_SWSS_COMMON_IMAGE
    USONIC_SWSS_COMMON_IMAGE=usonic-swss-common
endif

ifndef USONIC_SAIREDIS_IMAGE
    USONIC_SAIREDIS_IMAGE=usonic-sairedis
endif

ifndef USONIC_SWSS_IMAGE
    USONIC_SWSS_IMAGE=usonic-swss
endif

ifndef USONIC_CLI_IMAGE
    USONIC_CLI_IMAGE=usonic-cli
endif

all: swss-common sairedis swss run-image debug-image

cli:
	DOCKER_BUILDKIT=1 docker build $(DOCKER_BUILD_OPTION) -f docker/cli.Dockerfile \
							      -t $(USONIC_CLI_IMAGE):$(USONIC_IMAGE_TAG) .

swss-common:
	DOCKER_BUILDKIT=1 docker build $(DOCKER_BUILD_OPTION) -f docker/build-swss-common.Dockerfile \
							      -t $(USONIC_SWSS_COMMON_IMAGE):$(USONIC_IMAGE_TAG) .

sairedis:
	DOCKER_BUILDKIT=1 docker build $(DOCKER_BUILD_OPTION) --build-arg USONIC_SWSS_COMMON_IMAGE=$(USONIC_SWSS_COMMON_IMAGE):$(USONIC_IMAGE_TAG) \
							      -f docker/build-sairedis.Dockerfile \
							      -t $(USONIC_SAIREDIS_IMAGE):$(USONIC_IMAGE_TAG) .

swss:
	DOCKER_BUILDKIT=1 docker build $(DOCKER_BUILD_OPTION) --build-arg USONIC_SWSS_COMMON_IMAGE=$(USONIC_SWSS_COMMON_IMAGE):$(USONIC_IMAGE_TAG) \
							      --build-arg USONIC_SAIREDIS_IMAGE=$(USONIC_SAIREDIS_IMAGE):$(USONIC_IMAGE_TAG) \
							      -f docker/build-swss.Dockerfile \
							      -t $(USONIC_SWSS_IMAGE):$(USONIC_IMAGE_TAG) .

run-image:
	DOCKER_BUILDKIT=1 docker build $(DOCKER_BUILD_OPTION) --build-arg USONIC_SWSS_COMMON_IMAGE=$(USONIC_SWSS_COMMON_IMAGE):$(USONIC_IMAGE_TAG) \
							      --build-arg USONIC_SAIREDIS_IMAGE=$(USONIC_SAIREDIS_IMAGE):$(USONIC_IMAGE_TAG) \
							      --build-arg USONIC_SWSS_IMAGE=$(USONIC_SWSS_IMAGE):$(USONIC_IMAGE_TAG) \
							      -f docker/run.Dockerfile \
							      -t $(USONIC_RUN_IMAGE):$(USONIC_IMAGE_TAG) .

debug-image:
	DOCKER_BUILDKIT=1 docker build $(DOCKER_BUILD_OPTION) --build-arg USONIC_SWSS_COMMON_IMAGE=$(USONIC_SWSS_COMMON_IMAGE):$(USONIC_IMAGE_TAG) \
							      --build-arg USONIC_SAIREDIS_IMAGE=$(USONIC_SAIREDIS_IMAGE):$(USONIC_IMAGE_TAG) \
							      --build-arg USONIC_SWSS_IMAGE=$(USONIC_SWSS_IMAGE):$(USONIC_IMAGE_TAG) \
							      -f docker/debug.Dockerfile \
							      -t $(USONIC_DEBUG_IMAGE):$(USONIC_IMAGE_TAG) .

run:
	-kubectl delete pods --force --grace-period=0 --timeout=0 usonic
	kubectl create -f ./files/usonic.yaml

bash:
	$(MAKE) cmd

cmd:
	docker run -it -v `pwd`:/data -w /data --privileged --rm $(USONIC_DEBUG_IMAGE) $(DOCKER_CMD)
