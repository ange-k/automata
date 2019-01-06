set :output, "/app/log/cron.log"
set :whenever_command, "bundle exec whenever"
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# # cronを実行する環境変数をセット
ENV.each { |k, v| env(k, v) }
set :environment, rails_env
# UTCです。(- 9:00)
# 16:00, 19:00, 23:00, 7:00
every '0 7,10,14,21 * * *' do
  rake "import_tweets:exec"
end

every '30 7,10,14,21 * * *' do
  rake "choice_category:exec"
end
