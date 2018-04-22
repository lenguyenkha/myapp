source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.4"
gem "sqlite3"
gem "puma", "~> 3.7"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "bcrypt", "3.1.11"
gem "bootstrap-sass", "3.3.7"
gem "jquery-rails", "4.3.1"
gem "rubocop", "~> 0.51.0", require: false
gem "config", "~> 1.6.1"
gem "faker", "1.7.3"
gem "will_paginate", "3.1.6"
gem "bootstrap-will_paginate", "1.0.0"
gem "carrierwave", "1.1.0"
gem "mini_magick", "4.7.0"
gem "fog-aws", "2.0.0"
gem "nokogiri", "1.8.1"
gem "roo", "2.7.1"
gem "font-awesome-sass", "~> 4.7.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "rails-controller-testing", "1.0.2"
  gem "minitest-reporters", "1.1.14"
  gem "guard", "2.13.0"
  gem "guard-minitest", "2.4.4"
end

group :production do
  gem "rails_12factor"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
