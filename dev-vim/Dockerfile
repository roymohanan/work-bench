FROM dev-base:latest

ARG user=devroy
USER $user

RUN sudo apt-get update && sudo apt-get install -y \
	vim \
	exuberant-ctags \
	python3 \
	python3-pip \
	python3-dev \
	python3-venv &&\
    sudo rm -rf /var/lib/apt/lists/*

RUN  mkdir -p /home/$user/.vim/autoload /home/$user/.vim/bundle &&\
     curl -LSso /home/$user/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

RUN cd /home/$user/.vim/bundle && \
    git clone https://github.com/scrooloose/nerdtree &&\
    git clone https://github.com/tpope/vim-surround &&\
    git clone https://github.com/vim-airline/vim-airline &&\
    git clone https://github.com/vim-airline/vim-airline-themes.git &&\
    git clone https://github.com/kien/ctrlp.vim &&\
    git clone https://github.com/majutsushi/tagbar &&\
    git clone https://github.com/airblade/vim-gitgutter.git

RUN cd /home/$user/.vim/bundle && \
    git clone https://github.com/tpope/vim-fugitive &&\
    vim -u NONE -c "helptags vim-fugitive/doc" -c q

RUN cd /home/$user/.vim/bundle && \
    git clone --depth 1  https://github.com/Valloric/YouCompleteMe &&\
    cd YouCompleteMe &&\
    git submodule update --init --recursive &&\
    python3 install.py

RUN vim -E -c 'execute pathogen#helptags()' -c q ; return 0

COPY .vimrc /home/$user
