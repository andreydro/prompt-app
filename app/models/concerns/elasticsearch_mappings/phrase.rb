# frozen_string_literal: true

# Legacy file
module ElasticsearchMappings
  module Phrase
    extend ActiveSupport::Concern

    included do
      include Elasticsearch::Model
      include Elasticsearch::Model::Callbacks
      index_name(
        "phrases#{Rails.env.production? ? '' : '-'}#{Rails.env}"
      )
    end

    def as_indexed_json(_options = {})
      PhraseSerializer.new.serialize(self).compact
    end
  end
end
