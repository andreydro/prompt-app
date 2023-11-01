# Requirements:

Ruby: 3.2.2
Rails: 7.1.1
Redis
Sidekiq
PostgreSQL
Elasticsearch 7.x

# Initial setup

- bundle install
- rails db:create
- rails db:migrate
- redis-server
- bundle exec sidekiq

# Load phrases to database

- rails db:seed

# Manage elasticsearch

Make sure that elastic search is running on port 9200

- Create index with rake es:create_index
- Update index with rake es:update_index

# Run tests

- bundle exec rspec spec

# Start server

- rails s

