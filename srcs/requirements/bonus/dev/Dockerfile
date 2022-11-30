FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
	apt-get install -y build-essential \
					   valgrind \
					   curl 
RUN apt-get install	 -y  wget \
					   nano \
					   vim \
					   python3 \
					   man-db \
					   git \
					   gdb \
					   htop \
					   dialog \
					   openssh-server \
					   ca-certificates \
					   make &&\
	apt-get clean -y && \
	apt-get autoclean -y && \
	apt-get autoremove -y

#Change the root to the dev container

#Devcontainer working directory
RUN mkdir -p /home/devcontainer

#Oh My Bash
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

ARG WORK_DIR

WORKDIR /home/devcontainer

ENV DEBIAN_FRONTEND=dialog

