FROM openjdk:8-slim

# Env vars
ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

# System setup
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y vim git zip unzip less curl
RUN apt-get install -y ca-certificates procps
RUN apt-get install -y libpq-dev python3 python3-pip build-essential

# install other package
RUN pip3 install setuptools wheel

# install dbt-postgres
RUN pip3 install --no-cache-dir dbt-postgres

# digdag install
RUN curl -o ~/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest" \
    && chmod +x ~/bin/digdag

# digdag用ワークフォルダの作成
RUN mkdir -p /app/digdag/run_dbt

# digdag server用フォルダの作成
RUN mkdir -p /app/digdag/run_dbt/logs
RUN mkdir -p /app/digdag/run_dbt/logs/accesslogs
RUN mkdir -p /app/digdag/run_dbt/logs/tasklogs

COPY profiles.yml /root/.dbt/profiles.yml

WORKDIR /usr/app/dbt/
VOLUME /usr/app
ENTRYPOINT tail -f /dev/null
