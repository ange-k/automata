class ToppagesController < ApplicationController
  def index
    @tweet = Tweet.includes(:popular).order("populars.popular desc")
  end
end
