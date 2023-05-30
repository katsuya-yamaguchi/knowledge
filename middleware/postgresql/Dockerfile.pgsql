FROM postgres:14

ARG POSTGRES_PASSWORD

ENV PGDATA /var/lib/postgresql/data

RUN apt-get update && \
    apt-get install -y git build-essential postgresql-server-dev-14 curl

WORKDIR /var/tmp

# pg_hint_planのインストール
RUN git clone -b PG14 https://github.com/ossc-db/pg_hint_plan.git && \
    cd pg_hint_plan && \
    make && \
    make install

# pgBaderのインストール
RUN curl -OL  https://github.com/darold/pgbadger/archive/refs/tags/v12.1.tar.gz && \
    tar zxvf v12.1.tar.gz && \
    cd pgbadger-12.1 && \
    perl Makefile.PL && \
    make && \
    make install
