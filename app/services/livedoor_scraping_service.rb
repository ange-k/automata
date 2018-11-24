class LivedoorScrapingService < ScrapingService
  def initialize(url, file_path, category, limit)
    @url = url
    @file_path = file_path
    @category = category
    @limit = limit
    file_init(file_path)
  end

  def scraping
    (1..@limit).each do |page|
      url = "#{@url}/?p=#{page}"

      session = capybara_create
      ankers = index_scraping(session, url)
      next if ankers.blank?
      result = pages_scraping(session, ankers)
      super(result, @file_path, @category)
      session.driver.quit #phantomJsのメモリ増加を抑えるため
    end
  end

  private

  def index_scraping(session, url)
    ankers = []
    p url if Rails.env == 'development'

    begin
      session.visit url
    rescue => e
      logger.error e
      return nil
    end

    unless session.status_code == 200
      p "status=#{session.status_code}"
      logger.warn "HttpStatusError=#{session.status_code}"
      return nil
    end
    news_list = session.find('.articleList').all('a')
    news_list.each do |node|
      begin
        ankers.push node[:href]
      rescue => e
        logger.error e
        next
      end
    end
    ankers
  end

  def pages_scraping(session, ankers)
    result = []

    ankers.each do |anker|

      begin
        session.visit anker
      rescue => e
        logger.error e
        next
      end

      unless session.status_code == 200
        p "status=#{session.status_code}"
        logger.warn "HttpStatusError=#{session.status_code}"
        next
      end
      container = session.all('.summaryList')
      if container.blank?
        logger.info "概要なしパターン:#{anker}"
        container = session.find('.articleBody')
        text = container.text
      else
        text = ''
        container.first.all('li').each do |node|
          text = "#{text}#{node.text}。"
        end
      end

      if text.blank?
        logger.warn "text blank. url=#{anker}"
        next
      end
      result.push text
    end
    result
  end
end