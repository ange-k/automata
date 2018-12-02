class ToppagesController < ApplicationController
  def index
    @tweet = Tweet.includes(:popular).order("populars.popular desc")
    @categories = Category.all
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
      render :json  => {result: 'success', html: html, id: id }
    else
      render :json  => {result: 'fail'}
    end
  end
end
