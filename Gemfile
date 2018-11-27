source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.6'
gem 'mysql2', '>= 0.3.18', '< 0.6.0'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'haml-rails'
gem 'erb2haml'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

# user関連処理
# gem 'devise'
# gem 'cancancan'
# gem 'rails_admin'

# bootstrap
gem 'bootstrap', '~> 4.1.1'
gem 'jquery-rails'

# automata
gem 'twitter'
gem 'dotenv-rails'
gem 'whenever', require: false
gem 'nokogiri'
gem 'poltergeist'
gem 'capybara'
gem 'natto'
gem 'seed-fu'

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
