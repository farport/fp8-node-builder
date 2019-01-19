# ===========================================================
# Author:   Marcos Lin
# Created:  14 Dec 2018
#
# Makefile used to create a node based image to build projects
#
# ===========================================================

# Docker Related
include $(FP8_HOME)/make/docker.makefile



# variables provided by $(FP8_HOME)/make/common.makefile
DOCKER_BUILD_OPTIONS := \
	--build-arg userId=$(CUR_USER_ID) \
	--build-arg groupId=$(CUR_GROUP_ID)

DOCKER_RUN_OPTIONS   := --rm \
	-u $(CUR_USER_ID):$(CUR_GROUP_ID) \
	-v $(YARN_CACHE):/var/cache/yarn

connect-root : $(IMAGE_BUILD_CHECK)
	@echo "- Creating $(CONTAINER_NAME) from $(IMAGE_NAME)"
	@docker run --rm \
		-v $(YARN_CACHE):/var/cache/yarn
		--name $(CONTAINER_NAME) -it $(IMAGE_NAME) /bin/sh



# Dependecies
SSH_KEY_FILE         := $(BUILD_DIR)/id_git_rsa.key

$(SSH_KEY_FILE) : $(BUILD_DIR)
ifeq (${FP8_GIT_SSHKEY},)
	$(error FP8_GIT_SSHKEY env must exist pointing to a ssh key that can access git repo.)
endif
	@echo "- Copying ${FP8_GIT_SSHKEY} file"
	@cp ${FP8_GIT_SSHKEY} $@

setup-deps : $(SSH_KEY_FILE)
