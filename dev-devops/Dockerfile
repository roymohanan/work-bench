FROM dev-node

ARG user=devroy
USER $user

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION=eu-west-1

# aws cli

ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
ENV AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
RUN sudo -H pip3 install awscli
RUN complete -C '/usr/local/bin/aws_completer' aws

# terraform
RUN cd /tmp &&\
    wget -q https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip &&\
    unzip terraform_0.11.11_linux_amd64.zip &&\
    sudo mv terraform /usr/local/bin &&\
    rm -rf terraform_0.11.11_linux_amd64.zip

#  kubectl dependency
RUN sudo apt-get update &&\
    sudo apt-get install -y apt-transport-https gnupg2 &&\
    sudo rm -rf /var/lib/apt/lists/*
	

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - &&\
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list &&\
    sudo apt-get update &&\
    sudo apt-get install -y kubectl &&\
    sudo rm -rf /var/lib/apt/lists/*

RUN sudo npm install -g serverless
