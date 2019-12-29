#!/bin/bash

cd ~/gthnk
SETTINGS=/home/gthnk/.gthnk/gthnk.conf /home/gthnk/venv/bin/manage.py user_del -e "$1"
