class PhraseBatchesCreationJob < ApplicationJob
  queue_as :default

  def perform(row)
    PhrasesCreator.new(row).call
  end
end
