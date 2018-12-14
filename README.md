# node-builder

A docker image to build node based project.  This is designed to be built
by each developer as it require a SSH Key used to access git repositories.

## Requirements

The full path to a passphrase-less ssh key needs to be set in the `FP8_GIT_SSHKEY`
environmental variable

## Usage

1. `git clone git@github.com:farport/node-builder.git`
1. `cd node-builder`
1. `make setup`

The image `node-builder` should now be avaible to be used.

Use `make connect` to launch a shell to the docker image.

#### Project Specific Images

As the name of the docker image is sourced from the name of the parent
directory, to create a project specific builder can be easily accomplished
by adding this as a submodule.  E.g.:

```
cd <proj name>
mkdir docker
cd docker
git submodules add git@github.com:farport/fp8-node-builder.git ./proj_name_builder
```
