namespace :import_ynews do
  desc 'Yahooから記事情報をインポートする'
  def logger
    Rails.logger
  end

  def exec_task(targets, root_dir)
    targets.each do |target|
      factory = ScrapingerFactory.new(target, root_dir)
      service = factory.build
      service.scraping
    end
  end

  # タスクのエントリポイント
  task exec: :environment do
    require 'capybara/poltergeist'
    root_dir = "#{Rails.root}/out"
    targets = [ScrapingerFactory::CATEGORY_IT_NEWS]

    exec_task targets, root_dir
  end

  task exec_livedoor: :environment do
    require 'capybara/poltergeist'
    root_dir = "#{Rails.root}/out"
    targets = [
        ScrapingerFactory::CATEGORY_LOCAL_NEWS,
        ScrapingerFactory::CATEGORY_WORLD_NEWS,
        ScrapingerFactory::CATEGORY_ECO_NEWS,
        ScrapingerFactory::CATEGORY_ENT_NEWS,
        ScrapingerFactory::CATEGORY_SPORTS_NEWS,
        ScrapingerFactory::CATEGORY_NET_NEWS
    ]

    exec_task targets, root_dir
  end
end
