#!/bin/bash

cd ~/gthnk
SETTINGS=/home/gthnk/.gthnk/gthnk.conf /home/gthnk/venv/bin/manage.py user_add -e "$1" -p "$2"
