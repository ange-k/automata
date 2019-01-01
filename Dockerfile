FROM ruby:2.5.1

ENV LANG C.UTF-8
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.6.0

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

ARG APP_HOME

ENV PATH      $APP_HOME/node_modules:$PATH
ENV PATH      $APP_HOME/node_modules/.bin:$PATH

ENV ENTRYKIT_VERSION 0.4.0

ENV PYTHONIOENCODING "utf-8"

ADD /usr/local/bin/ /usr/local/bin

WORKDIR /app

RUN bundle config build.nokogiri --use-system-libraries
ADD . /app
RUN bundle install -j3 --path vendor/bundle
ADD ./bin/export.sh /opt
