# Container Control

CONTAINER=iandennismiller/gthnk

all: build run
	@echo ok

run:
	docker run -it --rm -p 1620:1620 -v ~/.gthnk:/home/user/.gthnk $(CONTAINER)

daemonize:
	docker run -d --rm --name gthnk -p 1620:1620 -v ~/.gthnk:/home/user/.gthnk $(CONTAINER) sh -c "sudo -i -u user SETTINGS=/home/user/.gthnk/gthnk.conf .venv/bin/runserver.py"

build:
	docker build -t $(CONTAINER):latest .

push:
	docker push $(CONTAINER)

shell:
	docker exec -it gthnk bash

.PHONY: all run daemonize build push
