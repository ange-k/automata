class ScrapingService
  def logger
    Rails.logger
  end

  def file_init(path)
    FileUtils.rm_rf(path) if FileTest.exist?(path)
    FileUtils.mkdir_p(path)
  end

  def capybara_create
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(
          app,
          js_errors: false,
          timeout: 10, # seconds
          phantomjs_options: %w(--load-images=no --ignore-ssl-errors=yes --ssl-protocol=any)
      )
    end
    Capybara.default_max_wait_time = 20
    session = Capybara::Session.new(:poltergeist)
    session
  end

  def scraping(result, file_path, category)
    mecab = Natto::MeCab.new('-d /usr/local/lib/mecab/dic/mecab-ipadic-neologd')

    result.each do |text|
      meishi = []
      next if text.blank?
      mecab.parse(text.tr('０-９ａ-ｚＡ-Ｚ', '0-9a-zA-Z')) do |nat|
        meishi.push(nat.surface) if nat.feature.split(',').first == '名詞'
      end
      File.open("#{file_path}/#{category}.txt", 'a') do |f|
        f.puts("__label__#{category} , #{meishi.join(' ')}")
      end
    end
  end
end