# fp8-node-builder

A docker image to build node based project.

## Volumes

* `/var/cache/yarn`: cache for `yarn` packages.  Mount to a local directory so that
  the packages can be re-used.

## Usage

* `make setup`:   build docker image
* `make clean`:   reomve docker image
* `make connect`: connect to image using `sh`

## Local Builder

* `cd node-builder-local; make setup`:   create developer specific local builder

