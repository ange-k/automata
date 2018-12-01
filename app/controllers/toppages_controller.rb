class ToppagesController < ApplicationController
  protect_from_forgery with: :null_session # todo
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
      html = render_to_string partial: 'tr', locals: { tw: tweet, index: index }
      render :json  => {result: 'success', html: html }
    else
      render :json  => {result: 'fail'}
    end
  end
end
