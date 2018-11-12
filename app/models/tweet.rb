class Tweet < ApplicationRecord
  has_many   :popular
  belongs_to :user
end
