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
		-v ~/.gthnk:/home/gthnk/storage \
		$(CONTAINER)

daemonize:
	docker run \
		-d \
		--rm \
		--name gthnk \
		-p 1620:1620 \
		-v ~/.gthnk:/home/gthnk/storage \
		$(CONTAINER)

build:
	docker build -t $(CONTAINER):latest .

push:
	docker push $(CONTAINER)

config:
	$(CONTAINER_EXEC) gthnk-config-init.sh /home/gthnk/storage/gthnk.conf

db:
	$(CONTAINER_EXEC) gthnk-db-init.sh

user-add:
	$(CONTAINER_EXEC) gthnk-user-add.sh $(EMAIL) $(PASSWORD)

user-del:
	$(CONTAINER_EXEC) gthnk-user-del.sh $(EMAIL)

rotate:
	$(CONTAINER_EXEC) gthnk-rotate.sh

shell:
	docker exec -it gthnk bash

.PHONY: all run daemonize build push
