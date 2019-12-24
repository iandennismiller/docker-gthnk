FROM ubuntu:18.04

ARG USERNAME=gthnk
ARG USERHOME=/home/gthnk
ARG USERID=1000
ARG USERGECOS=gthnk
ARG DEBIAN_FRONTEND=noninteractive

RUN adduser \
  --home "$USERHOME" \
  --uid $USERID \
  --gecos "$USERGECOS" \
  --disabled-password \
  "$USERNAME"

RUN apt-get update && \
  apt-get install -y apt-utils && \
  apt-get upgrade -y && \
  apt-get install -y \
    sudo \
    gnupg \
    vim \
    git \
    git-core \
    make \
    wget \
    curl \
    procps \
    openssh-server \
    tzdata \
    htop \
    telnet \
    net-tools \
    tmux \
    tigervnc-standalone-server \
    xfce4 \
    xfce4-goodies \
    xterm \
    firefox && \
  apt-get --purge remove -y .\*-doc$ && \
  apt-get clean -y

RUN service ssh start

###
# Install configuration files
# To download configuration: make download

COPY files/ /home/$USERNAME
RUN chown -R $USERNAME:$USERNAME /home/$USERNAME

RUN apt-get install -y \
  python \
  python-dev \
  python-pip \
  build-essential \
  sqlite-dev

RUN pip install --upgrade pip && \
  pip install --upgrade virtualenv && \
  pip install virtualenvwrapper

RUN pip install gthnk
