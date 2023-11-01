class PhrasesCreator
  def initialize(row)
    @row = row
  end

  def call
    phrases.each do |phrase|
      next if phrase.blank?

      Phrase.create!(value: phrase.strip)
    end
  end

  private

  def phrases
    @row['row']['Prompt'].split(',')
  end
end
