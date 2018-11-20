namespace :import_ynews do
  desc 'Yahooから記事情報をインポートする'
  def logger
    Rails.logger
  end

  def scraping(url, path, session, category)
    begin
      session.visit url
      anker_list = []

      # yNews 20個のリストに表示されるURLを取得。
      table = session.all('.ListBoxwrap')
      table.each do |node|
        ankers = node.all('a')
        ankers.each do |anker|
          next if anker.text.blank?
          anker_list.push anker[:href]
        end
      end

      # スレッド処理のほうがいいかも
      # 個別のニュース記事にアクセスして見出しを取る
      news_header = []
      anker_list.each do |anker|
        begin
          session.visit anker
          table = session.all('.hbody')
          table.each do |node|
            news_header.push node.text
          end
        rescue => err
          logger.error err
        end
      end

      # 個別のニュースの見出しをMecabにかける
      mecab = Natto::MeCab.new
      news_header.each do |header|
        meishi = []
        mecab.parse(header.tr('０-９ａ-ｚＡ-Ｚ', '0-9a-zA-Z')) do |nat|
          meishi.push(nat.surface) if nat.feature.split(',').first == '名詞'
        end
        File.open("#{path}/ynews.txt", 'a') do |f|
          f.puts("__label__#{category} , #{meishi.join(' ')}")
        end
      end

    rescue => evar
      logger.error evar
    end
  end

  def import_news(category, path)
    page_count = 500
    yURL = "https://news.yahoo.co.jp/list/?c=#{category}"

    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, {
          :js_errors => false,
          :timeout => 5000,
          phantomjs_options: [
              '--load-images=no',    # HTTPS エラー無視
              '--ignore-ssl-errors=yes',
              '--ssl-protocol=any']
      })
    end
    Capybara.default_max_wait_time = 20
    session = Capybara::Session.new(:poltergeist)

    (1..page_count).each do |page|
      url = "#{yURL}&p=#{page}"
      logger.info url
      scraping(url, path, session, category)
    end

  end

  # タスクのエントリポイント
  task exec: :environment do
    require 'capybara/poltergeist'

    root_dir = "#{Rails.root}/out"
    FileUtils.rm_rf(root_dir) if FileTest.exist?(root_dir)
    FileUtils.mkdir_p(root_dir)

    categories = [
        'domestic',      # 国内
        'world',         # 海外
        'economy',       # 経済
        'entertainment', # エンタメ
        'sports',        # スポーツ
        'computer',      # IT
        'science',       # 科学
        'local'          # 地域
    ]
    categories.each do |category|
      logger.info "処理開始->#{category}"
      make_path = "#{root_dir}/#{category}"
      FileUtils.mkdir_p(make_path)
      import_news(category, make_path)
    end
  end
end
