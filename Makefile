ifndef DOCKER_CMD
    DOCKER_CMD=bash
endif

ifndef DOCKER_IMAGE
    DOCKER_IMAGE=usonic-builder
endif

ifndef DOCKER_RUN_IMAGE
    DOCKER_RUN_IMAGE=usonic
endif

ifndef DOCKER_DEBUG_IMAGE
    DOCKER_DEBUG_IMAGE=usonic-debug
endif

docker-image:
	DOCKER_BUILDKIT=1 docker build $(DOCKER_BUILD_OPTION) -f docker/build.Dockerfile -t $(DOCKER_IMAGE) .

docker-run-image:
	DOCKER_BUILDKIT=1 docker build $(DOCKER_BUILD_OPTION) -f docker/run.Dockerfile -t $(DOCKER_RUN_IMAGE) .

docker-debug-image:
	DOCKER_BUILDKIT=1 docker build $(DOCKER_BUILD_OPTION) -f docker/debug.Dockerfile -t $(DOCKER_DEBUG_IMAGE) .

install:
	

bash:
	$(MAKE) cmd

cmd:
	docker run -it -v `pwd`:/data -w /data --privileged --rm $(DOCKER_IMAGE) $(DOCKER_CMD)
