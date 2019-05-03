FROM ubuntu:18.04

ARG user=devroy
RUN echo $user
RUN apt-get update && \
	apt-get install sudo -y && \
	adduser --disabled-password --gecos '' $user && \
	adduser $user sudo && \
	echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Language related options
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8
ENV LC_ALL=en_GB.UTF-8
ENV LANG=en_GB.UTF-8
ENV LANGUAGE=en_GB.UTF-8

RUN apt-get update && \
    apt-get install -y \
	language-pack-en-base \
        locales &&\
	apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN locale-gen en_GB.UTF-8

# Required for `clear` command to work, etc.
ENV TERM screen-256color

# For some reason, this environment variable isn't set by docker.
ENV USER $user

ENV HOME /home/$user

# Main installs
COPY build.sh /tmp/build.sh

RUN bash /tmp/build.sh && \
	rm /tmp/build.sh

WORKDIR /home/$user

USER $user
