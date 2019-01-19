# node-builder-local

A docker image used build node based project.  This image is designed to be built
by each developer as it require a SSH Key used to access git repositories.

## Requirements

* A passphrase-less ssh key needs to be set in the `FP8_GIT_SSHKEY` env variable
* A `$(FP8_HOME)/cache/fp8-node-builder/yarncache` directory created as a shared yarn-cache directory

## Creating Docker Image

* `make setup`: build docker image

## Docker Image Usage

#### Initialize Project

The command below clones the project from a git repo into the `/proj` directory
of docker container, that is in turn a local volume defined by `PROJ_CACHE`

```
docker run --rm \
	-u $(CUR_USER_ID):$(CUR_GROUP_ID) \
	-v $(PROJ_CACHE):/proj \
	--name $(DOCKER_INST_NAME) -it $(BUILDER_IMAGE_NAME) \
	/bin/execs.sh \
    "git clone $(GIT_PROJ_URL) /proj"
```

#### Build Project

The source code must be pushed to git repo before running this command.  The example
below will pull any changes from git repo and build the `webapp` subdirectory.

```
docker run --rm \
	-v $(YARN_CACHE):/var/cache/yarn \
	-v $(PROJ_CACHE):/proj \
	-u $(CUR_USER_ID):$(CUR_GROUP_ID) \
	--name $(DOCKER_INST_NAME) -it $(BUILDER_IMAGE_NAME) \
	/bin/execs.sh \
    "cd /proj && git checkout $(GIT_BRANCH) && git pull" \
    "cd /proj/webapp && yarn install && yarn build"
```

#### Note

* `PROJ_CACHE`: A local directory where the project will be cloned and built.  This is needed
                so subsequent build does not require cloning of the project again.

