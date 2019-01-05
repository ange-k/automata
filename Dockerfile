FROM 991180925719.dkr.ecr.ap-northeast-1.amazonaws.com/rails5-ecr

RUN apt-get update -qq && \
 apt-get install -y --no-install-recommends \
  cron && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN bundle config build.nokogiri --use-system-libraries
ADD . /app
RUN bundle install -j3 --path vendor/bundle
ADD ./bin/start.sh /opt
RUN chmod +x /opt/start.sh

RUN chmod +x /app/script/*.sh
RUN chmod +x /app/script/python/*.py

ENTRYPOINT ["/opt/start.sh"]
