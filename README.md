# docker-gthnk

## Quick start with Docker

```
docker run -d \
    -p 1620:1620 \
    -v ~/.gthnk:/home/gthnk/.gthnk \
    iandennismiller/gthnk
```

## Normal usage

Edit the `Makefile` to choose a username and password.

```
git clone https://github.com/iandennismiller/docker-gthnk
make run db user
```
