FROM ubuntu:14.04
MAINTAINER Vishal Lall "vishal.lall@caci.com"
LABEL Description="Dockerfile for bitcoin blockchain" Version="0.1"
EXPOSE 5000

RUN apt-get update && apt-get install -y \
   build-essential \
   curl \
   python-dev \
   python-pip \
   python-yaml \
   subversion \
   unzip \
   gzip \
   wget \
   postgresql \
   pgadmin3

RUN pip install \
   flask \
   flask-api

# Postgres
RUN service postgresql start
RUN sudo -u postgres psql postgres
RUN sudo -u postgres createdb blockchain
RUN sudo -u webbtc

# Get Blockchain
RUN useradd -ms /bin/bash ubuntu
USER ubuntu
WORKDIR /home/ubuntu/Downloads
RUN git clone https://github.com/vlall/dockchain
RUN gzip ~/Downloads/bitcoin_2014-02-28.sql.gz | psql -U postgres blockchain
WORKDIR /home/ubuntu
