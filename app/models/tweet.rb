class Tweet < ApplicationRecord
  has_many   :popular
  belongs_to :user

  def text_only
    text_str = self.text
    URI.extract(text_str).uniq.each {|url| text.gsub!(url, '')}
    text_str.chomp
  end
end
