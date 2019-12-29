# Container Control

CONTAINER=iandennismiller/gthnk
EMAIL=user@example.com
PASSWORD=secret
CONTAINER_EXEC=docker exec -it gthnk sudo -i -u gthnk

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

config:
	$(CONTAINER_EXEC) gthnk-config-init.sh /home/gthnk/.gthnk/gthnk.conf

db:
	$(CONTAINER_EXEC) gthnk-db-init.sh

user-add:
	$(CONTAINER_EXEC) gthnk-user-add.sh $(EMAIL) $(PASSWORD)

user-del:
	$(CONTAINER_EXEC) gthnk-user-del.sh $(EMAIL)

shell:
	docker exec -it gthnk bash

.PHONY: all run daemonize build push
