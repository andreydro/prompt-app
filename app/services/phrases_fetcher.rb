class PhrasesFetcher
  BATCH_SIZE = 100

  def call
    current_offset = 0
    number_of_batches.times do
      rows = rows_request(current_offset)
      current_offset += BATCH_SIZE
      next if rows.blank?

      handle_rows(rows)
    end
  end

  private

  def rows_request(current_offset)
    response = DatasetsClient.new(BATCH_SIZE, current_offset).request
    response['rows']
  end

  def handle_rows(rows)
    rows.each do |row|
      handle_row_and_create_phrases(row)
    end
  end

  def handle_row_and_create_phrases(row)
    phrases = row['row']['Prompt'].split(',')

    phrases.each do |phrase|
      next if phrase.blank?

      Phrase.create!(value: phrase.strip)
    end
  end

  def number_of_batches
    (total_rows_number / BATCH_SIZE.to_f).ceil
  end

  def total_rows_number
    response = DatasetsClient.new.request
    response['num_rows_total']
  end
end
