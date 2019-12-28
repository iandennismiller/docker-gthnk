# Container Control

CONTAINER=iandennismiller/gthnk
EMAIL=user@example.com
PASSWORD=secret

all: build run
	@echo ok

run:
	docker run \
		-it \
		--rm \
		--name gthnk \
		-p 1620:1620 \
		-v ~/.gthnk:/home/gthnk/.gthnk \
		$(CONTAINER)

daemonize:
	docker run \
		-d \
		--rm \
		--name gthnk \
		-p 1620:1620 \
		-v ~/.gthnk:/home/gthnk/.gthnk \
		$(CONTAINER)

build:
	docker build -t $(CONTAINER):latest .

push:
	docker push $(CONTAINER)

db:
	docker exec -it gthnk sudo -i -u gthnk sh -c 'cd ~/gthnk && SETTINGS=/home/gthnk/.gthnk/gthnk.conf /home/gthnk/.venv/bin/manage.py init_db'

user:
	docker exec -it gthnk sudo -i -u gthnk sh -c 'cd ~/gthnk && SETTINGS=/home/gthnk/.gthnk/gthnk.conf /home/gthnk/.venv/bin/manage.py user_add -e $(EMAIL) -p $(PASSWORD)'

shell:
	docker exec -it gthnk bash

.PHONY: all run daemonize build push
