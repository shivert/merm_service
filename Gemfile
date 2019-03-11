source 'https://rubygems.org'
ruby '2.5.0'


gem 'rails', '~> 5.1.4'
gem 'puma', '~> 3.7'
gem 'paranoia', '~> 2.2'

# ElasticSearch
gem 'elasticsearch-model'

# GraphQL
gem 'graphql'
gem 'graphiql-rails'

# Authentication
gem 'devise', '>=4.4'
gem 'devise-token_authenticatable', '>=1.0.2'

gem 'rack-cors'

group :production do
  gem 'pg'
end

group :development do
  gem 'rb-readline'
  gem 'annotate'
  gem 'faker'
  gem 'byebug'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'rspec'
  gem 'rspec-rails'
  gem 'sqlite3'
end

group :test do
  # Clean Database between tests
  gem 'database_cleaner'
  # Programmatically start and stop ES for tests
  gem 'elasticsearch-extensions'
  gem 'sqlite3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
