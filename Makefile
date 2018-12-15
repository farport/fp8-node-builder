#!/bin/bash

# ===========================================================
# Author:   Marcos Lin
# Created:  14 Dec 2018
#
# Makefile used to create a node based image to build projects
#
# ===========================================================

ROOT_DIR             := $(shell pwd)
BUILD_DIR            := $(ROOT_DIR)/build
SSH_KEY_FILE         := $(BUILD_DIR)/id_git_rsa.key

DOCKER_IMAGE         := $(shell basename $(shell pwd))
DOCKER_INST_NAME     := $(DOCKER_IMAGE)-inst
DOCKER_INST_ID        = $(shell docker ps -aqf"name=$(DOCKER_INST_NAME)")
DOCKER_IMAGE_ID       = $(shell docker images -qf"reference=$(DOCKER_IMAGE)")
DOCKER_BUILD_CHECK   := $(BUILD_DIR)/docker.built

CURR_USER_ID         := $(shell id -u ${USER})
CURR_GROUP_ID        := $(shell id -g ${USER})

# ------------------
# USAGE: First target called if no target specified
man :
	@cat README.md


# ------------------
# MAIN TARGETS
$(BUILD_DIR) :
	mkdir -p $@

$(SSH_KEY_FILE) : $(BUILD_DIR)
ifeq (${FP8_GIT_SSHKEY},)
	$(error FP8_GIT_SSHKEY env must exist pointing to a ssh key that can access git repo.)
endif
	@echo "- Copying ${FP8_GIT_SSHKEY} file"
	@cp ${FP8_GIT_SSHKEY} $@
	
$(DOCKER_BUILD_CHECK) : $(SSH_KEY_FILE)
ifeq ($(shell which docker),)
	$(error docker command needed to be installed.)
endif
	@echo "- Building $(DOCKER_IMAGE) image"
	docker build \
		--build-arg userId=$(CURR_USER_ID) \
		--build-arg groupId=$(CURR_GROUP_ID) \
		-f Dockerfile -t $(DOCKER_IMAGE) .
	touch $@

setup : $(DOCKER_BUILD_CHECK)

connect : $(DOCKER_BUILD_CHECK)
	@echo "- Connecting to $(DOCKER_IMAGE) docker image"
	@docker run --rm \
		-v $(BUILD_DIR):/output \
		-u $(CURR_USER_ID):$(CURR_GROUP_ID) \
		--name $(DOCKER_INST_NAME) -it $(DOCKER_IMAGE) /bin/sh

connect-root : $(DOCKER_BUILD_CHECK)
	@echo "- Connecting to $(DOCKER_IMAGE) docker image"
	@docker run --rm \
		-v $(BUILD_DIR):/output \
		--name $(DOCKER_INST_NAME) -it $(DOCKER_IMAGE) /bin/sh

clean :
ifneq ($(DOCKER_INST_ID),)
	@echo "### Removing docker instance $(DOCKER_INST_ID)"
	@docker rm $(DOCKER_INST_ID)
endif
ifneq ($(DOCKER_IMAGE_ID),)
	@echo "### Removing docker image $(DOCKER_IMAGE_ID)"
	@docker rmi $(DOCKER_IMAGE_ID)
endif
	rm -rf $(BUILD_DIR)


# ------------------
# DEFINE PHONY TARGET: Basically all targets
.PHONY : \
	man setup connect clean
