class Tweet < ApplicationRecord
  has_many   :popular
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :correct, class_name: 'Category', foreign_key: 'correct', optional: true

  def text_only
    text_str = self.text

    # url 除去
    URI.extract(text_str).uniq.each { |url| text.gsub!(url, '') }
    text_str.chomp!

    # ハッシュタグ除去
    text_str.gsub!(/[#＃][Ａ-Ｚａ-ｚA-Za-z一-鿆0-9０-９ぁ-ヶｦ-ﾟー]+/, '')

    # 固有文字表現の削除
    text_str.gsub!(/[<(＜（]アーカイヴ記事[>)＞）]/, '')
    text_str.gsub!('■今人気の記事■', '')

    # 空白削除
    text_str.gsub!(/[\r\n]/, '')
    text_str.strip

    Shellwords.escape(text_str)
  end
end
