FROM iandennismiller/vnc:latest

# Set up the virtual environment
RUN sudo -i -u user virtualenv .venv
RUN sudo -i -u user .venv/bin/pip install -U pip

# Install Gthnk
RUN sudo -i -u user .venv/bin/pip install   git+https://github.com/iandennismiller/gthnk.git@master

# Legacy; supports logging, somehow...
RUN mkdir /var/lib/gthnk
RUN chown user /var/lib/gthnk

# Puts the configuration into place
COPY files/ /home/user
RUN chown -R user:user /home/user/.gthnk /home/user/.ssh

# Clone the git repo
RUN sudo -i -u user git clone https://github.com/iandennismiller/gthnk.git

# Initialize the database
RUN sudo -i -u user sh -c 'cd gthnk && SETTINGS=/home/user/.gthnk/gthnk.conf /home/user/.venv/bin/manage.py init_db'

# use 'make daemonize' to run the following
# RUN sudo -i -u user SETTINGS=/home/user/.gthnk/gthnk.conf /home/user/.venv/bin/runserver.py
