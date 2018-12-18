#!/bin/bash

# ===========================================================
# Author:   Marcos Lin
# Created:  14 Dec 2018
#
# Makefile used to create a node based image to build projects
#
# ===========================================================

ROOT_DIR           := $(shell pwd)
BUILD_DIR          := $(ROOT_DIR)/build

IMAGE_BASE         := $(shell basename $(ROOT_DIR))
IMAGE_VERSION      := 8.14.0
IMAGE_NAME         := farport/$(IMAGE_BASE):$(IMAGE_VERSION)
CONTAINER_NAME     := $(IMAGE_BASE)-inst
IMAGE_BUILD_CHECK  := $(BUILD_DIR)/docker.built

CUR_USER_ID        := $(shell id -u ${USER})
CUR_GROUP_ID       := $(shell id -g ${USER})

IMAGE_ID            = $(shell docker images -qf"reference=$(IMAGE_NAME)")
CONTAINER_ID        = $(shell docker ps -aqf"name=$(CONTAINER_NAME)")

# ------------------
# USAGE: First target called if no target specified
man :
	@cat README.md

# ------------------
# MAIN TARGETS
$(BUILD_DIR) :
	mkdir -p $@
	
$(IMAGE_BUILD_CHECK) : $(BUILD_DIR)
ifeq ($(shell which docker),)
	$(error docker command needed to be installed.)
endif
	@echo "- Building $(IMAGE_NAME)"
	docker build \
		-f Dockerfile -t $(IMAGE_NAME) .
	touch $@

setup : $(IMAGE_BUILD_CHECK)

connect : $(IMAGE_BUILD_CHECK)
	@echo "- Connecting to $(DOCKER_IMAGE) docker image"
	@docker run \
		--name $(CONTAINER_NAME) -it $(IMAGE_NAME) /bin/sh

clean :
ifneq ($(CONTAINER_ID),)
	@echo "### Removing docker container $(CONTAINER_ID)"
	@docker rm $(CONTAINER_ID)
endif
ifneq ($(IMAGE_ID),)
	@echo "### Removing docker image $(IMAGE_ID)"
	@docker rmi $(IMAGE_ID)
endif
	rm -rf $(BUILD_DIR)

# ------------------
# DEFINE PHONY TARGET: Basically all targets
.PHONY : \
	man setup connect clean
