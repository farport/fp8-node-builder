# node-builder

A docker image to build node based project.  This is designed to be built
by each developer as it require a SSH Key used to access git repositories.

## Requirements

* A passphrase-less ssh key needs to be set in the `FP8_GIT_SSHKEY` env variable
* This project must be a submodule of another git project, aka parent git project
* parent git project must have been created using ssh url and accessiable by `FP8_GIT_SSHKEY`

The parent git project is cloned to `/proj` in the image.

## Usage

1. `git submodule add clone git@github.com:farport/node-builder.git ./proj-node-builder`
1. `cd proj-node-builder`
1. `make setup`

The image `proj-node-builder` should now be avaible to be used.

Use `make connect` to launch a shell to the docker image.
