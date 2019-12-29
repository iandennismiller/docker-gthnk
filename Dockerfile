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

# Copy home directory structure
COPY files/home/ /home/$USERNAME/
RUN chown -R $USERNAME:$USERNAME /home/$USERNAME

# Set up the virtual environment
# RUN apt install -y libzstd-dev
RUN sudo -i -u gthnk virtualenv -p /usr/bin/python2 /home/gthnk/venv

# Clone the git repo
RUN sudo -i -u gthnk git clone https://github.com/iandennismiller/gthnk.git

# Install Gthnk
RUN sudo -i -u gthnk /home/gthnk/venv/bin/pip install git+https://github.com/iandennismiller/gthnk.git@master

# Legacy; supports logging, somehow...
RUN mkdir /var/lib/gthnk
RUN chown gthnk:gthnk /var/lib/gthnk

# Initialize storage path
RUN mkdir /home/gthnk/storage
RUN chown gthnk:gthnk /home/gthnk/storage

# Initialize the image
RUN sudo -i -u gthnk gthnk-firstrun.sh /home/gthnk/storage/gthnk.conf

# 1) Generate configuration if necessary
# 2) Launch the Gthnk server
CMD if [ ! -f /home/gthnk/storage/gthnk.conf ]; then \
  sudo -i -u gthnk gthnk-firstrun.sh /home/gthnk/storage/gthnk.conf; \
  fi; \
  sudo -i -u gthnk gthnk-server.sh
