source "https://rubygems.org"

gem "devise"
gem "rails", "4.1.6"
gem "organizer"
gem "omniauth"
gem "omniauth-facebook"
gem "twitter"
gem "google-api-client", :require => "google/api_client"
gem "omniauth-google-oauth2"
gem "cancancan", "~> 1.9"
gem "bootstrap-sass"
gem "sass-rails", "~> 4.0.3"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.0.0"
gem "carrierwave"
gem "rails-settings-cached", "0.4.1"
gem "mini_magick"
gem "jquery-rails"
gem "turbolinks"
gem "jbuilder", "~> 2.0"
gem "sdoc", "~> 0.4.0",		group: :doc
gem "spring",        		group: :development
gem "aws-sdk"
gem "fog", require: "fog/aws/storage"
gem "gibbon"
gem "json"


group :development, :test do
  gem "sqlite3"
end

group :test do
  gem "capybara"
  gem "guard-rspec"
  gem "factory_girl_rails"
  gem "rspec-rails"
  gem "faker"
  gem "shoulda-matchers", require: false
end

group :production do
   gem "pg"
   gem "rails_12factor"
end
