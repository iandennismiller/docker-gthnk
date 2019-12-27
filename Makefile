# Container Control

CONTAINER=iandennismiller/gthnk

all: build run
	@echo ok

run:
	docker run -it --rm -p 1620:1620 -v ~/.gthnk:/home/gthnk/.gthnk $(CONTAINER)

daemonize:
	docker run -d --rm --name gthnk -p 1620:1620 -v ~/.gthnk:/home/gthnk/.gthnk $(CONTAINER) sh -c "sudo -i -u gthnk SETTINGS=/home/gthnk/.gthnk/gthnk.conf .venv/bin/runserver.py"

build:
	docker build -t $(CONTAINER):latest .

push:
	docker push $(CONTAINER)

shell:
	docker exec -it gthnk bash

.PHONY: all run daemonize build push
