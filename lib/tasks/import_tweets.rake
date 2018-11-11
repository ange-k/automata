namespace :import_tweets do
  desc 'Twitterから記事情報をインポートする'
  def logger
    Rails.logger
  end

  # タスクのエントリポイント
  task exec: :environment do
    client_init
    options = {
        count: 1,
        include_rts: false
    }
    @client.home_timeline(options).each do |tweet|
      p tweet.user.id              # twitter id
      p tweet.user.name            # user name
      p tweet.user.followers_count # フォロワー数
      p tweet.user.statuses_count  # 発信数
      p tweet.id                   # tweet id
      p tweet.text                 # tweet
      p tweet.retweet_count        # リツイート数
      p tweet.favorite_count       # お気に入り数
      tweet.urls.each do |entity|
        p entity.url.to_s          # url
      end
      p tweet.created_at           # 発言日
    end
  end

  def client_init
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end
end
