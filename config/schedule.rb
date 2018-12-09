# UTCです。(- 9:00)

# 7:00, 16:00, 23:00
every 1.day, at: ['10:00 pm', '7:00 am', '2:00 pm'] do
  rake "import_tweets:exec"
end

# 7:30, 16:30, 23:30
every 1.day, at: ['10:30 pm', '7:30 am', '2:30 pm'] do
  rake "choice_category:exec"
end
