FROM ubuntu:18.04

LABEL maintainer="scinterv <scinterv@gmail.com>"

ARG PASSWORD="123456"
ENV NOTVISIBLE "in users profile"

WORKDIR /root

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && apt-get update --fix-missing \
# RUN apt-get update \
    # Install packages
    && apt-get install -y iproute2 net-tools ctags curl wget vim openssh-server git make cmake \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    # Configure ssh
    && mkdir /var/run/sshd \
    && echo "root:${PASSWORD}" | chpasswd \
    && sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    # SSH login fix. Otherwise user is kicked off after login
    && sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd \
    && echo "export VISIBLE=now" >> /etc/profile \
    # Install Pathogen
    && mkdir -p .vim/autoload .vim/bundle \
    && curl -LSso .vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim \
    && echo "execute pathogen#infect('~/.vim/bundle/{}')" >> .vimrc \
    && echo "syntax on" >> .vimrc \
    && echo "filetype plugin indent on" >> .vimrc

# Plugins
RUN cd .vim/bundle/ \
    && git clone --depth 1 https://github.com/pangloss/vim-javascript \
    && git clone --depth 1 https://github.com/scrooloose/nerdcommenter \
    && git clone --depth 1 https://github.com/godlygeek/tabular \
    && git clone --depth 1 https://github.com/Raimondi/delimitMate \
    && git clone --depth 1 https://github.com/nathanaelkane/vim-indent-guides \
    && git clone --depth 1 https://github.com/groenewege/vim-less \
    && git clone --depth 1 https://github.com/othree/html5.vim \
    && git clone --depth 1 https://github.com/elzr/vim-json \
    && git clone --depth 1 https://github.com/bling/vim-airline \
    && git clone --depth 1 https://github.com/easymotion/vim-easymotion \
    && git clone --depth 1 https://github.com/mbbill/undotree \
    && git clone --depth 1 https://github.com/majutsushi/tagbar \
    && git clone --depth 1 https://github.com/vim-scripts/EasyGrep \
    && git clone --depth 1 https://github.com/jlanzarotta/bufexplorer \
    && git clone --depth 1 https://github.com/kien/ctrlp.vim \
    && git clone --depth 1 https://github.com/scrooloose/nerdtree \
    && git clone --depth 1 https://github.com/jistr/vim-nerdtree-tabs \
    && git clone --depth 1 https://github.com/scrooloose/syntastic \
    && git clone --depth 1 https://github.com/tomtom/tlib_vim \
    && git clone --depth 1 https://github.com/marcweber/vim-addon-mw-utils \
    && git clone --depth 1 https://github.com/vim-scripts/taglist.vim \
    && git clone --depth 1 https://github.com/terryma/vim-expand-region \
    && git clone --depth 1 https://github.com/tpope/vim-fugitive \
    && git clone --depth 1 https://github.com/airblade/vim-gitgutter \
    && git clone --depth 1 https://github.com/fatih/vim-go \
    && git clone --depth 1 https://github.com/plasticboy/vim-markdown \
    && git clone --depth 1 https://github.com/michaeljsmith/vim-indent-object \
    && git clone --depth 1 https://github.com/terryma/vim-multiple-cursors \
    && git clone --depth 1 https://github.com/tpope/vim-repeat \
    && git clone --depth 1 https://github.com/tpope/vim-surround \
    && git clone --depth 1 https://github.com/vim-scripts/mru.vim \
    && git clone --depth 1 https://github.com/vim-scripts/YankRing.vim \
    && git clone --depth 1 https://github.com/tpope/vim-haml \
    && git clone --depth 1 https://github.com/SirVer/ultisnips \
    && git clone --depth 1 https://github.com/honza/vim-snippets \
    && git clone --depth 1 https://github.com/derekwyatt/vim-scala \
    && git clone --depth 1 https://github.com/christoomey/vim-tmux-navigator \
    && git clone --depth 1 https://github.com/ekalinin/Dockerfile.vim \
    # Theme
    && git clone --depth 1 https://github.com/altercation/vim-colors-solarized

# Install and compile procvim.vim
RUN mkdir -p .vim/colors \
    && cp -r .vim/bundle/vim-colors-solarized/colors/solarized.vim .vim/colors/ \
    && git clone --depth 1 https://github.com/Shougo/vimproc.vim .vim/vimproc.vim \
    && cd .vim/vimproc.vim \
    && make

COPY .vimrc my.vimrc
COPY basic.vim ./
COPY extended.vim ./

# Build default .vimrc
RUN mv -f .vimrc .vimrc~ \
    # history dir for yanking
    && mkdir -p .vim_runtime/temp_dirs \
    && cat basic.vim >> .vimrc~ \
    && cat extended.vim >> .vimrc~ \
    && cat my.vimrc >> .vimrc~ \
    && rm -rf my.vimrc basic.vim extended.vim \
    && sed -i '/colorscheme peaksea/d' .vimrc~ \
    && mv .vimrc~ .vimrc

# Pathogen help tags generation
RUN vim -E -c 'execute pathogen#helptags()' -c q ; return 0

ENV TERM=xterm-256color

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
