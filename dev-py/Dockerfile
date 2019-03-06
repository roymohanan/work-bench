FROM dev-vim:latest

ARG user=devroy
USER $user

RUN sudo apt update && sudo apt install -y \
	python3-pip \
	python3-dev \
	python3-venv &&\
     sudo rm -rf /var/lib/lists/*

COPY requirements.txt /tmp/

RUN  sudo pip3 install --no-cache-dir -r /tmp/requirements.txt
