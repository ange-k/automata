class ItmediaScrapingService < ScrapingService
  def initialize(url, file_path, calendar)
    @url = url
    @file_path = file_path
    @calendar = calendar
    file_init(file_path)
  end

  def scraping
    session = capybara_create
    @calendar.each do |date|
      url = "#{@url}/#{date}"
      ankers = index_scraping(session, url)
      next if ankers.blank?
      result = pages_scraping(session, ankers)
      super(result, @file_path, ScrapingerFactory::CATEGORY_IT_NEWS)
    end
  end

  private

  def index_scraping(session, url)
    require 'objspace'

    ankers = []
    p url if Rails.env == 'development'
    logger.info "sysmem: #{ObjectSpace.memsize_of_all}"

    session.visit url
    unless session.status_code == 200
      p "status=#{session.status_code}"
      logger.warn "HttpStatusError=#{session.status_code}"
      return nil
    end
    news_list = session.find('.colBoxBacknumber').all('a')
    news_list.each do |node|
      ankers.push node[:href]
    end
    ankers
  end

  def pages_scraping(session, ankers)
    result = []

    ankers.each do |anker|
      session.visit anker

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