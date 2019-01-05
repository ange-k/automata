#!/bin/bash
export RAILS_ENV=production
export ACCESS_TOKEN=$(aws ssm get-parameters --region ap-northeast-1 --name chalkboard-twitter-access-token --query "Parameters[0].Value" --with-decryption --output text)
export ACCESS_TOKEN_SECRET=$(aws ssm get-parameters --region ap-northeast-1 --name chalkboard-twitter-access-token-secret --query "Parameters[0].Value" --with-decryption --output text)
export CONSUMER_KEY=$(aws ssm get-parameters --region ap-northeast-1 --name chalkboard-twitter-consumer-key --query "Parameters[0].Value" --with-decryption --output text)
export CONSUMER_SECRET=$(aws ssm get-parameters --region ap-northeast-1 --name chalkboard-twitter-consumer-secret --query "Parameters[0].Value" --with-decryption --output text)
export DATABASE_HOST=$(aws ssm get-parameters --region ap-northeast-1 --name chalkboard-db-host --query "Parameters[0].Value" --with-decryption --output text)
export DATABASE_PASSWORD=$(aws ssm get-parameters --region ap-northeast-1 --name chalkboard-db-pw --query "Parameters[0].Value" --with-decryption --output text)
export DATABASE_USER=$(aws ssm get-parameters --region ap-northeast-1 --name chalkboard-db-user --query "Parameters[0].Value" --with-decryption --output text)
export GOOGLE_CLIENT_ID=$(aws ssm get-parameters --region ap-northeast-1 --name chalkboard-google-client --query "Parameters[0].Value" --with-decryption --output text)
export GOOGLE_CLIENT_SECRET=$(aws ssm get-parameters --region ap-northeast-1 --name chalkboard-google-secret --query "Parameters[0].Value" --with-decryption --output text)
export SECRET_KEY_BASE=$(aws ssm get-parameters --region ap-northeast-1 --name chalkboard-automata-secret-key --query "Parameters[0].Value" --with-decryption --output text)

aws s3 cp s3://news-bin/model.bin /app/script/python

bundle exec rake db:migrate
bundle exec rake assets:clobber
bundle exec rake assets:precompile
bundle exec rails s -p 3000 -b 0.0.0.0

bundle exec whenever --update-crontab
service cron restart