# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PhrasesCreator do
  describe '#call' do
    let(:row) { { 'row' => { 'Prompt' => 'phrase1, phrase2, phrase3' } } }

    it 'creates phrases' do
      expect { described_class.new(row).call }.to change { Phrase.count }.by(3)
    end
  end
end
