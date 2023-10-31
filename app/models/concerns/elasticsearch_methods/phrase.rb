# frozen_string_literal: true

# Legacy file
module ElasticsearchMethods
  module Phrase
    extend ActiveSupport::Concern

    module ClassMethods
      def fulltext_search(query)
        query = { query: { bool: { must: [match: { value: query }] } }, size: 250 }

        search(query)
      end
    end
  end
end
