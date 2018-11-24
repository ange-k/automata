class ScrapingerFactory
  PATTERN_ITMEDIA = 1

  CATEGORY_IT_NEWS = 'it'

  def initialize(pattern, base_path)
    case(pattern)
    when PATTERN_ITMEDIA # it news
      url = 'http://www.atmarkit.co.jp/ait/subtop/archive'
      filepath = "#{base_path}/at_it"
      calendar = generate(Date.parse('2000-01-01'), Date.parse('2018-11-01'))
      @service = ItmediaScrapingService.new(url, filepath, calendar)
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