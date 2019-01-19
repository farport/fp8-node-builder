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

* `make setup-local`:   create developer specific local builder

## Release

#### 8.14.2 [01 Jan 2019]

* Added `app.fp8.docker.version.*` label to help track underlying dependencies
* Standarized docker build process
* Added instruction separating `git clone` and `build` in README for `node-builder-local`

#### 8.14.1 [19 Dec 2018]

* Create user bug fix 

#### 8.14.0 [18 Dec 2018]

* Initial Working Release
