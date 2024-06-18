source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.6"
gem 'rack-cors', require: 'rack/cors'
gem "rails", "~> 7.0.8", ">= 7.0.8.4"
gem "sqlite3", "~> 1.4"
gem 'uuid', '~> 2.3'
gem 'kaminari'
gem "puma", "~> 5.0"
gem 'devise'
gem 'pundit'
gem 'jwt'
gem 'sqlite3', group: [:development, :test]
gem 'pg', group: :production
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
end

