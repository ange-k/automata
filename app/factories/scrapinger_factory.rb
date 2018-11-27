class ScrapingerFactory
  CATEGORY_IT_NEWS = 'it'             # @it
  CATEGORY_LOCAL_NEWS = 'local'       # livedor-国内
  CATEGORY_WORLD_NEWS = 'world'       # livedor-世界
  CATEGORY_ECO_NEWS = 'economy'       # livedor-経済総合
  CATEGORY_ENT_NEWS = 'entertainment' # livedor-エンタメ
  CATEGORY_SPORTS_NEWS = 'sport'      # livedor-スポーツ
  CATEGORY_NET_NEWS = 'net'           # livedor-IT総合

  def self.scraping_targets
    return [
        CATEGORY_IT_NEWS,
        CATEGORY_LOCAL_NEWS,
        CATEGORY_WORLD_NEWS,
        CATEGORY_ECO_NEWS,
        CATEGORY_ENT_NEWS,
        CATEGORY_SPORTS_NEWS,
        CATEGORY_NET_NEWS
    ]
  end


  def initialize(pattern, base_path)
    case(pattern)
    when CATEGORY_IT_NEWS # it news
      url = 'http://www.atmarkit.co.jp/ait/subtop/archive'
      filepath = "#{base_path}/at_it"
      calendar = generate(Date.parse('2000-01-01'), Date.parse('2018-11-01'))
      @service = ItmediaScrapingService.new(url, filepath, calendar)
    when CATEGORY_LOCAL_NEWS
      url = 'http://news.livedoor.com/topics/category/dom'
      filepath = "#{base_path}/ld_local"
      @service = LivedoorScrapingService.new(url, filepath, pattern, 100)
    when CATEGORY_WORLD_NEWS
      url = 'http://news.livedoor.com/topics/category/world'
      filepath = "#{base_path}/ld_world"
      @service = LivedoorScrapingService.new(url, filepath, pattern, 100)
    when CATEGORY_ECO_NEWS
      url = 'http://news.livedoor.com/article/category/2'
      filepath = "#{base_path}/ld_eco"
      @service = LivedoorScrapingService.new(url, filepath, pattern, 30)
    when CATEGORY_NET_NEWS
      url = 'http://news.livedoor.com/article/category/210'
      filepath = "#{base_path}/ld_net"
      @service = LivedoorScrapingService.new(url, filepath, pattern, 30)
    when CATEGORY_ENT_NEWS
      url = 'http://news.livedoor.com/topics/category/ent'
      filepath = "#{base_path}/ld_ent"
      @service = LivedoorScrapingService.new(url, filepath, pattern, 50)
    when CATEGORY_SPORTS_NEWS
      url = 'http://news.livedoor.com/topics/category/sports'
      filepath = "#{base_path}/ld_sports"
      @service = LivedoorScrapingService.new(url, filepath, pattern, 50)
    end
  end

  def build
    @service
  end

  private

  def generate(b, e)
    enumrator = Enumerator.new do |yielder|
      head = b
      while head <= e
        yielder << head
        head = head.next_month
      end
    end
    result = []
    enumrator.each do |date|
      result.push("#{date.year.to_s.slice(2,3)}#{date.month.to_s.rjust(2, '0')}.html")
    end
    result
  end
end