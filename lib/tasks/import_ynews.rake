namespace :import_ynews do
  desc 'Yahooから記事情報をインポートする'
  def logger
    Rails.logger
  end

  def scraping(url, path, session)
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

    rescue => evar
      logger.error evar
    end
  end

  def import_news(category, path)
    page_count = 2
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
      scraping(url, path, session)
    end

  end

  # タスクのエントリポイント
  task exec: :environment do
    require 'capybara/poltergeist'

    root_dir = "#{Rails.root}/out"
    FileUtils.rm_rf(root_dir) if FileTest.exist?(root_dir)
    FileUtils.mkdir_p(root_dir)

    categories = [
        'domestic',     # 国内
#        'world',        # 海外
#        'economy',      # 経済
#        'entertainment',# エンタメ
#        'sports',       # スポーツ
#        'computer',     # IT
#        'science',      # 科学
        'local'         # 地域
    ]
    categories.each do |category|
      make_path = "#{root_dir}/#{category}"
      FileUtils.mkdir_p(make_path)
      import_news(category, make_path)
    end
  end
end
