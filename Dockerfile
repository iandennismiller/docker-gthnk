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
COPY files/home/ /home/$USERNAME/
RUN chown -R $USERNAME:$USERNAME /home/$USERNAME

# Clone the git repo
RUN sudo -i -u gthnk git clone https://github.com/iandennismiller/gthnk.git

# Set up the virtual environment
RUN sudo -i -u gthnk virtualenv /home/gthnk/venv

# Install Gthnk
RUN sudo -i -u gthnk /home/gthnk/venv/bin/pip install git+https://github.com/iandennismiller/gthnk.git@master

# Legacy; supports logging, somehow...
RUN mkdir /var/lib/gthnk
RUN chown gthnk:gthnk /var/lib/gthnk

# Initialize the configuration
RUN sudo -i -u gthnk gthnk-config-init.sh /home/gthnk/.gthnk/gthnk.conf

# Initialize the database
RUN sudo -i -u gthnk gthnk-db-init.sh

# Create a user with EMAIL and PASSWORD
RUN sudo -i -u gthnk gthnk-user-add.sh user@example.com secret

# 1) Generate configuration if necessary
# 2) Launch the Gthnk server
CMD if [ ! -f /home/gthnk/.gthnk/gthnk.conf ]; then \
  sudo -i -u gthnk gthnk-config-init.sh /home/gthnk/.gthnk/gthnk.conf; \
  fi; \
  sudo -i -u gthnk gthnk-server.sh
