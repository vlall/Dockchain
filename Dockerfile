FROM ubuntu:14.04
MAINTAINER V Lall
LABEL Description="Dockerfile for bitcoin blockchain" Version="0.2"

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    wget \
    gzip \
    python-dev \
    python-pip \
    python-yaml \
    python-software-properties \
    software-properties-common \
    postgresql-9.3 \
    postgresql-client-9.3 \
    postgresql-contrib-9.3

RUN pip install \
    flask \
    flask-api

#  Ingest to Postgres
USER postgres
RUN /etc/init.d/postgresql start &&\
    psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
    createdb -O docker blockchain
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf
RUN mkdir ~/Downloads
WORKDIR ~/Downloads
RUN wget http://dumps.webbtc.com/bitcoin/bitcoin_2014-02-28.sql.gz
RUN gzip bitcoin_2014-02-28.sql.gz | psql -U docker blockchain
RUN git clone https://github.com/vlall/dockchain

EXPOSE 5432
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]
WORKDIR ~
