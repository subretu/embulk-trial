FROM openjdk:8-slim

# timezone (Asia/Tokyo)
ENV TZ JST-9

ENV PATH_TO_EMBULK=/opt/embulk \
    PATH=${PATH}:/opt/embulk

# system update && tools
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y vim git zip unzip less curl
RUN apt-get install -y ca-certificates

# locale
RUN apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8

# etc
ENV TERM xterm

# Embulk install（一時的な回避策で-kを使用・・・）
RUN mkdir -p ${PATH_TO_EMBULK} \
    && curl -k --create-dirs -o ${PATH_TO_EMBULK}/embulk -L "http://dl.embulk.org/embulk-latest.jar" \
    && chmod +x ${PATH_TO_EMBULK}/embulk

# digdag install
RUN curl -o ~/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest" \
    && chmod +x ~/bin/digdag

# PostgreSQL用プラグインのインストール
RUN embulk gem install embulk-input-postgresql
RUN embulk gem install embulk-output-postgresql
# filter用プラグインをインストール
RUN embulk gem install embulk-filter-column
# S3用プラグインのインストール
RUN embulk gem install embulk-output-s3

# digdag用ワークフォルダの作成
RUN mkdir -p /app/digdag

WORKDIR /app
#COPY ./config.yml ./

CMD [ "bash" ]