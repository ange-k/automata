FROM ruby:2.5.1

ENV LANG C.UTF-8

RUN apt-get update -qq && \
 apt-get install -y --no-install-recommends \
  build-essential \
  gcc \
  zlib1g-dev \
  libpq-dev \
  libfontconfig1 && \
  rm -rf /var/lib/apt/lists/*

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.6.0

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# ARG命令でdocker-compose.ymlから渡されたAPP_HOMEという引数を参照できるようにします
# ローカルモードでインストールしたパッケージをshellから利用できるようにパスを通す
ARG APP_HOME

ENV PATH      $APP_HOME/node_modules:$PATH
ENV PATH      $APP_HOME/node_modules/.bin:$PATH

ENV ENTRYKIT_VERSION 0.4.0

RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && mv entrykit /bin/entrykit \
  && chmod +x /bin/entrykit \
  && entrykit --symlink

RUN wget -O /tmp/phantomjs-2.1.1-linux-x86_64.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
  && bzip2 -dc /tmp/phantomjs-2.1.1-linux-x86_64.tar.bz2 | tar xvf - \
  && mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /bin \
  && chmod +x /bin/phantomjs

# python
RUN wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz \
      && tar zxf Python-3.6.0.tgz \
      && cd Python-3.6.0 \
      && ./configure \
      && make altinstall
ENV PYTHONIOENCODING "utf-8"

# mecab
WORKDIR /opt
RUN git clone https://github.com/taku910/mecab.git
WORKDIR /opt/mecab/mecab
RUN ./configure  --enable-utf8-only \
  && make \
  && make check \
  && make install \
  && ldconfig

WORKDIR /opt/mecab/mecab-ipadic
RUN ./configure --with-charset=utf8 \
  && make \
  &&make install

WORKDIR /opt
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git
WORKDIR /opt/mecab-ipadic-neologd
RUN ./bin/install-mecab-ipadic-neologd -n -y

WORKDIR /opt
RUN git clone https://github.com/facebookresearch/fastText.git
WORKDIR fastText
RUN pip3.6 install .

RUN mkdir /app
RUN pip3.6 install awscli

WORKDIR /app

RUN bundle config build.nokogiri --use-system-libraries

ADD . /app
ADD ./bin/export.sh /opt

ENTRYPOINT [ \
  "prehook", "ruby -v", "--", \
  "prehook", "bundle install -j3", "--"]
