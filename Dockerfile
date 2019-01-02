FROM 991180925719.dkr.ecr.ap-northeast-1.amazonaws.com/rails5-ecr

WORKDIR /app

RUN bundle config build.nokogiri --use-system-libraries
ADD . /app
RUN bundle install -j3 --path vendor/bundle
ADD ./bin/start.sh /opt
RUN chmod +x /opt/start.sh

ENTRYPOINT ["/opt/start.sh"]
