FROM iandennismiller/python:latest

###
# Add a basic user

ARG USERNAME=gthnk
ARG USERHOME=/home/gthnk
ARG USERID=1000
ARG USERGECOS=gthnk

RUN adduser \
  --home "$USERHOME" \
  --uid $USERID \
  --gecos "$USERGECOS" \
  --disabled-password \
  "$USERNAME"
COPY files/home/ /home/$USERNAME
RUN chown -R $USERNAME:$USERNAME /home/$USERNAME

# Set up the virtual environment
RUN sudo -i -u gthnk virtualenv .venv
RUN sudo -i -u gthnk .venv/bin/pip install -U pip

# Install Gthnk
RUN sudo -i -u gthnk .venv/bin/pip install   git+https://github.com/iandennismiller/gthnk.git@master

# Legacy; supports logging, somehow...
RUN mkdir /var/lib/gthnk
RUN chown gthnk:gthnk /var/lib/gthnk

# Clone the git repo
RUN sudo -i -u gthnk git clone https://github.com/iandennismiller/gthnk.git

# Initialize the database
# RUN sudo -i -u gthnk sh -c 'cd ~/gthnk && SETTINGS=/home/gthnk/.gthnk/gthnk.conf /home/gthnk/.venv/bin/manage.py init_db'

# Create a user with EMAIL and PASSWORD
# RUN sudo -i -u gthnk SETTINGS=/home/gthnk/.gthnk/gthnk.conf /home/gthnk/.venv/bin/manage.py user_add -e EMAIL -p PASSWORD

# Launch the gthnk server
CMD sudo -i -u gthnk SETTINGS=/home/gthnk/.gthnk/gthnk.conf /home/gthnk/.venv/bin/runserver.py
