ScrapingerFactory.scraping_targets.each_with_index do |category, index|
  Category.seed do |c|

    case(category)
    when ScrapingerFactory::CATEGORY_IT_NEWS
      c.name = 'IT'
    when ScrapingerFactory::CATEGORY_LOCAL_NEWS
      c.name = '国内'
    when ScrapingerFactory::CATEGORY_WORLD_NEWS
      c.name = '海外'
    when ScrapingerFactory::CATEGORY_SPORTS_NEWS
      c.name = 'スポーツ'
    when ScrapingerFactory::CATEGORY_ECO_NEWS
      c.name = '経済'
    when ScrapingerFactory::CATEGORY_NET_NEWS
      c.name = 'ネット'
    when ScrapingerFactory::CATEGORY_ENT_NEWS
      c.name = 'エンタメ'
    end
    c.id = index + 1
    c.label = "__label__#{category}"
  end
end
