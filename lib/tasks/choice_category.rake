namespace :choice_category do
  desc '記事のカテゴリを推定する'
  task exec: :environment do
    root_dir = Rails.root
    fasttext = Shellwords.escape("#{root_dir}/script/exec.sh")

    categories = Category.all.map do |category|
      [category.label, category.id]
    end
    categories = Hash[categories]
    Tweet.where(category_id: nil).each do |tweet|
      out, err, status = Open3.capture3("#{fasttext} #{tweet.text_only}")
      json = JSON.load(out).sort_by{ |_, v| -v }
      label = json.first.first
      value = json.first.second
      tweet.category_id = categories[label]
      tweet.score = value
      tweet.save
    end
  end
end
