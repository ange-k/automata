class ToppagesController < ApplicationController
  def index
    @tweet = Tweet.all
  end
end
