# Golang onbuild

Golang onbuild with x package.

## Base Docker Image

* [golang](https://store.docker.com/images/golang)

## Docker Tag

* 1.9

## Build docker image

```bash
docker build --force-rm --no-cache -t siriuszg/golang-onbuild:TAG .
```

## Howto

### Quick Start

```bash
ddocker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp siriuszg/golang-onbuild:TAG go build -v
```