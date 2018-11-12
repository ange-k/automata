namespace :import_tweets do
  desc 'Twitterから記事情報をインポートする'
  def logger
    Rails.logger
  end

  # タスクのエントリポイント
  task exec: :environment do
    client_init
    options = {
      count: 200,
      include_rts: false
    }
    @client.home_timeline(options).each do |tweet|
      user = User.find_or_create_by(
        tw_user_id: tweet.user.id.to_s
      )
      user.update(
        name: tweet.user.name,
        followers_count: tweet.user.followers_count,
        statuses_count: tweet.user.statuses_count
      )
      user.save

      tw = Tweet.find_or_create_by(
        tw_tweet_id: tweet.id.to_s,
        user_id: user.id
      )
      unless tw.text
        logger.info "new tweet:#{tw.tw_tweet_id}"
      end
      tw.update(
        text: tweet.text,
        urls: tweet.urls.map(&:url).map(&:to_s).join(','),
        tweet_at: tweet.created_at
      )
      tw.save

      popular = Popular.find_or_create_by(
        retweet_count: tweet.retweet_count,
        user_id: user.id,
        tweet_id: tw.id,
        favorite_count: tweet.favorite_count,
        popular: ((tweet.retweet_count / Math.sqrt(user.followers_count)) +
            (tweet.favorite_count / Math.sqrt(user.followers_count))) * 100
      )
      popular.update(
        search_date: DateTime.now
      )
      popular.save
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
