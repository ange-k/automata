class ItmediaScrapingService < ScrapingService
  def initialize(url, file_path, calendar)
    @url = url
    @file_path = file_path
    @calendar = calendar
    file_init(file_path)
  end

  def scraping
    @calendar.each do |date|
      url = "#{@url}/#{date}"
      session = capybara_create
      ankers = index_scraping(session, url)
      next if ankers.blank?
      result = pages_scraping(session, ankers)
      super(result, @file_path, ScrapingerFactory::CATEGORY_IT_NEWS)
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
    news_list = session.find('.colBoxBacknumber').all('a')
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

      container = session.find_by_id('cmsAbstract')
      if container.blank?
        logger.error "NotFound h2 container. url = #{anker}"
        next
      end
      h2 = container.find('h2')
      text = h2.text if h2.present?

      if h2.text.blank?
        logger.warn "h2 text blank. url=#{anker}"
        next
      end
      result.push text
    end
    result
  end
end