set :output, "/app/log/cron.log"
set :whenever_command, "bundle exec whenever"
# UTCです。(- 9:00)
# 7:00, 16:00, 23:00
every '0 22 * * *' do
  rake "import_tweets:exec"
end
every '0 7 * * *' do
  rake "import_tweets:exec"
end
every '0 14 * * *' do
  rake "import_tweets:exec"
end

# 7:30, 16:30, 23:30
every '30 22 * * *' do
  rake "choice_category:exec"
end
every '30 7 * * *' do
  rake "choice_category:exec"
end
every '30 14 * * *' do
  rake "choice_category:exec"
end