# Container Control

CONTAINER=analyzer
PORT=2200

include ../config.mak
include ../bin/container.mak

download:
	docker container cp analyzer:/home/analyzer/.rstudio-desktop/monitored/user-settings/user-settings \
		files/rstudio-user-settings.ini
	docker container cp analyzer:/home/analyzer/.config/RStudio/desktop.ini \
		files/rstudio-desktop.ini

.PHONY: all run destroy shell build push ssh-init ssh tunnel vnc cp download
