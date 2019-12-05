source 'https://rubygems.org'

ruby '2.3.3'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.1'

# Use sqlite 3 in development
group :development, :test do
  gem 'sqlite3', '~> 1.3', '>= 1.3.13'
end

group :development do
  gem 'rails_real_favicon', '~> 0.0.7'
end

group :production do
  gem 'pg', '~> 0.18'
end

gem 'puma', '~> 3.12'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'devise', '~> 4.2'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'rails-assets-tether', '~> 1.1', '>= 1.1.1'
gem 'bootstrap_form', '~> 2.3'
gem 'paperclip', '~> 5.2.0'
gem 'aws-sdk', '~> 2.3.0'
gem 'acts-as-taggable-on', github: 'mbleigh/acts-as-taggable-on'
gem 'mail_form', '~> 1.7'
gem 'sendgrid-ruby', '~> 5.2'
gem 'friendly_id', '~> 5.1.0'
gem 'trix', '~> 0.11.1'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
