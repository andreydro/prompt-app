class Phrase < ApplicationRecord
  include ElasticsearchMappings::Phrase
  include ElasticsearchMethods::Phrase

  validates :value, presence: true
end
