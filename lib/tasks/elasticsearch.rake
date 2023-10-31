# frozen_string_literal: true

# Legacy file
namespace :es do
  task update_index: :environment do
    Phrase.import(force: true)
  end

  task refresh_index: :environment do
    Phrase.__elasticsearch__.create_index!(force: true)

    Phrase.import(force: true)
  end

  task create_index: :environment do
    Phrase.__elasticsearch__.create_index!(force: true)
  end

  task remove_index: :environment do
    Phrase.__elasticsearch__.delete_index!
  end
end
