logger = Logger.new(Rails.root.join('log', "elasticsearch.#{Rails.env}.log"), 1, 100 * 1024 * 1024)
logger.level = Rails.env.development? ? Logger::DEBUG : Logger::WARN
host = ENV['BONSAI_URL'] || 'http://localhost:9200'
Elasticsearch::Model.client = Elasticsearch::Client.new(
  host:,
  logger:,
  retry_on_failure: 5,
  reload_connections: true,
  sniffer_timeout: 3
)
