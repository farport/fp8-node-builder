# fp8-node-builder

A docker image to build node based project.

## Version

The version is based on the major and minor version from node and build is the
build version number of this specific release.

## Volumes

* `/var/cache/yarn`: cache for `yarn` packages.  Mount to a local directory so that
  the packages can be re-used.

## Usage

* `make setup`:   build docker image
* `make clean`:   reomve docker image
* `make connect`: connect to image using `sh`

## Local Builder

* `cd node-builder-local; make setup`:   create developer specific local builder

## To Find Version of Alpine Linux

```
cat /etc/alpine-release
```