set :output, "/app/log/cron.log"
set :whenever_command, "bundle exec whenever"
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# # cronを実行する環境変数をセット
ENV.each { |k, v| env(k, v) }
set :environment, rails_env
# UTCです。(- 9:00)
# 7:00, 10:00, 16:00, 22:00
every '0 7,10,14,21 * * *' do
  rake "import_tweets:exec"
end

# 7:30, 10:30, 16:30, 22:30
every '30 7,10,14,21 * * *' do
  rake "choice_category:exec"
end
