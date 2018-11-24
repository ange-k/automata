class ItmediaScrapingService < ScrapingService
  def initialize(url, file_path, calendar)
    @url = url
    @file_path = file_path
    @calendar = calendar
    file_init(file_path)
  end

  def scraping
    session = capybara_create
    results = []
    @calendar.each do |date|
      url = "#{@url}/#{date}"
      ankers = index_scraping(session, url)
      results.push pages_scraping(session, ankers) if ankers.present?
    end

    super(results, @file_path, ScrapingerFactory::CATEGORY_IT_NEWS)
  end

  private

  def index_scraping(session, url)
    ankers = []
    p url if Rails.env == 'development'

    session.visit url
    unless session.status_code == 200
      p "status=#{session.status_code}"
      logger.warn 'HttpStatusエラー'
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
        logger.warn 'HttpStatusエラー'
        next
      end

      container = session.find_by_id('cmsAbstract')
      if container.blank?
        logger.error "NotFound h2 container. url = #{anker}"
        next
      end
      h2 = container.find('h2')
      text = h2.text if h2.present?
      result.push text
    end
    result
  end
end