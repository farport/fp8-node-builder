# local-node-builder

A docker image to build node based project.  This is designed to be built
by each developer as it require a SSH Key used to access git repositories.

## Requirements

* A passphrase-less ssh key needs to be set in the `FP8_GIT_SSHKEY` env variable
* This project must be a submodule of another git project, aka parent git project
* parent git project must have been created using ssh url and accessiable by `FP8_GIT_SSHKEY`
* A `~/.fp8-node-builder/yarncache/` directory created as a shared yarn-cache directory

## Usage

* `make setup-local`: Create local image named `local-node-builder`

## Sample

Following sample Makefile entry can be used to clone and build the project

```
docker run --rm \
	-v $(YARN_CACHE):/var/cache/yarn \
	-v $(PROJ_CACHE):/proj \
	-u $(CUR_USER_ID):$(CUR_GROUP_ID) \
	--name $(DOCKER_INST_NAME) -it $(BUILDER_IMAGE_NAME) \
	/bin/execs.sh \
    "git clone $(GIT_PROJ_URL) /proj" \
    "cd /proj && git checkout $(GIT_BRANCH) && git pull" \
    "cd /proj/webapp && yarn install && yarn build"
```
