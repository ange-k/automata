class GigazineScrapingService < ScrapingService
  def initialize(url, file_path, category, limit)
    @url = url
    @file_path = file_path
    @category = category
    @limit = limit
    file_init(file_path)
  end

  def scraping
    (0..@limit).each do |index|
      page = index * 40
      url = "#{@url}#{page}/"
      session = capybara_create

      ankers = index_scraping(session, url)
      next if ankers.blank?
      result = pages_scraping(session, ankers)

      super(result, @file_path, @category)
      session.driver.quit
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

    news_list = session.all('.content').first.all('a')
    news_list.each do |node|
      begin
        ankers.push node[:href]
      rescue => e
        logger.error e
        next
      end
    end
    ankers.uniq
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
      container = session.find('meta[property="description"]', visible: false )
      if container.blank?
        logger.error "NotFound h2 container. url = #{anker}"
        next
      end

      content = container[:content]

      if content.blank?
        logger.warn "content text blank. url=#{anker}"
        next
      end
      result.push content
    end
    result
  end
end
