# frozen_string_literal: true

class PhraseSerializer < ApplicationSerializer
  DEFAULT_ATTRIBUTES = %w[id value].freeze

  attributes(*DEFAULT_ATTRIBUTES)
end
