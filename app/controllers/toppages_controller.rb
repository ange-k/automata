class ToppagesController < ApplicationController
  before_action :authenticate_social_account!, only: [:index, :select, :category]
  def index
    @tweet = Tweet.eager_load(:popular).where(tweet_at: 1.week.ago..Time.zone.now).order(
        "DATE_FORMAT(tweets.tweet_at, '%Y%m%d%H') desc, populars.popular desc")
    @categories = Category.all
  end

  def select
    @tweet = Tweet.eager_load(:popular).where("tweets.correct is null").order("populars.popular desc")
    @categories = Category.all
    render 'index'
  end

  def category
    @categories = Category.all
    tweet_id = params['tweet_id']
    category_id = params['category_id']
    index = params['index']

    tweet = Tweet.find(tweet_id)
    tweet.correct = Category.find(category_id)
    if tweet.save
      id = "#tr-#{index}-#{tweet_id}"
      html = render_to_string partial: 'tr', locals: { tw: tweet, index: index.to_i }
      render :json  => { result: 'success', html: html, id: id }
    else
      render :json  => { result: 'fail' }
    end
  end
end
