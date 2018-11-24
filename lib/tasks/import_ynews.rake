namespace :import_ynews do
  desc 'Yahooから記事情報をインポートする'
  def logger
    Rails.logger
  end

  # タスクのエントリポイント
  task exec: :environment do
    require 'capybara/poltergeist'

    root_dir = "#{Rails.root}/out"

    targets = [ScrapingerFactory::PATTERN_ITMEDIA]

    targets.each do |target|
      factory = ScrapingerFactory.new(target, root_dir)
      service = factory.build
      service.scraping
    end
  end
end
