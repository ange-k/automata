namespace :choice_category do
  desc '記事のカテゴリを推定する'
  task exec: :environment do
    root_dir = Rails.root
    tw_path = "#{root_dir}/tmp/tweets"
    fasttext = Shellwords.escape("#{root_dir}/script/exec.sh")

    out, err, status = Open3.capture3("#{fasttext} #{Tweet.last.text_only}")
    p out
    p err
    p status

    #FileUtils.mkdir_p(tw_path)
    #ids = []
    #File.open("#{tw_path}/twitter.txt", 'w') do |f|
    #  File.open("#{tw_path}/ids.txt", 'w') do |f_id|
    #    Tweet.where(category_id: nil).each do |tw|
#
 #       end
  #    end
   # end


  end
end
