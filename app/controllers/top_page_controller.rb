class TopPageController < ApplicationController
  def index
    @tweet = Tweet.all
  end
end
