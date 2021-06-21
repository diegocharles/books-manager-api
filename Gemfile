source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'rails', '~> 6.1.3'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'jbuilder', '~> 2.7'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'jwt'

group :development, :test do
  gem 'pry'
  gem 'annotate'
  gem 'awesome_print'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rspec_api_documentation'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end
