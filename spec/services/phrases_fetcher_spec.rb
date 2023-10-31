# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PhrasesFetcher do
  describe '#call' do
    context 'when phrases are present' do
      before do
        allow_any_instance_of(DatasetsClient).to receive(:request).and_return(
          'rows' => [{
            'row' => {
              'Prompt' => 'phrase1, phrase2, phrase3'
            }
          }, {
            'row' => {
              'Prompt' => 'phrase4, phrase5, phrase6'
            }
          }],
          'num_rows_total' => 100
        )
      end

      it 'creates phrases' do
        expect { described_class.new.call }.to change(Phrase, :count).by(6)
      end
    end

    context 'when phrases are not present' do
      before do
        allow_any_instance_of(DatasetsClient).to receive(:request).and_return(
          'rows' => [],
          'num_rows_total' => 100
        )

        it 'does not create phrases' do
          expect { described_class.new.call }.not_to change(Phrase, :count)
        end
      end
    end
  end
end
