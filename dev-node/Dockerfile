FROM dev-py

ARG user=devroy
RUN echo $user

COPY build.sh /tmp/build.sh

# install nodjs and npm
RUN sudo bash /tmp/build.sh && \
    sudo rm /tmp/build.sh 

# install the vue framework
RUN sudo npm install -g http-server vue @vue/cli

WORKDIR /home/$user

USER $user
