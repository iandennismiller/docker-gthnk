#!/bin/bash

if [[ -z $1 ]]; then
    echo "error: configuration filename is required."
    echo "usage: gthnk-config-init.sh FILENAME"
    exit
fi

cat <<EOF > "$1"
PROJECT_NAME = "gthnk"
IP = "0.0.0.0"
PORT = 1620
DEBUG = False
LOG = "/home/gthnk/.gthnk/gthnk.log"
LOG_LEVEL = "DEBUG"
SQLALCHEMY_DATABASE_URI = "sqlite:////home/gthnk/.gthnk/gthnk.db"
SECRET_KEY = '\x19h\x83\x11\xef\xdeL\x92\xc2\xa4\xd5T&\xd0\xf1\x87\x91\x9bQ7\xe6\x18A\xea'

BASE_URL = "http://local.gthnk.com"

SECURITY_PASSWORD_SALT = 'O6msWfo5nkV7wIoh'
SECURITY_POST_LOGIN_VIEW = "/admin"
SECURITY_PASSWORD_HASH = 'sha256_crypt'
SECURITY_URL_PREFIX = '/user'
SECURITY_CHANGEABLE = True
SECURITY_SEND_PASSWORD_CHANGE_EMAIL = False

DEBUG = True
DEBUG_TOOLBAR = False # True
DEBUG_TB_INTERCEPT_REDIRECTS = False

MAIL_SERVER = 'localhost'
MAIL_PORT = 25
MAIL_USE_TLS = False
MAIL_USERNAME = None
MAIL_PASSWORD = None

CELERY_BROKER_URL = 'sqla+sqlite:///home/gthnk/.gthnk/celery-db.sqlite'
CELERY_RESULT_BACKEND = 'db+sqlite:///home/gthnk/.gthnk/celery-results.sqlite'

BACKUP_PATH = "/home/gthnk/.gthnk/backup"
INPUT_FILES = "/home/gthnk/.gthnk/journal.txt"
PROJECT_PATH = "/home/gthnk/.gthnk/Work"
EXPORT_PATH = "/home/gthnk/.gthnk/export"
EOF
