# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PhrasesFetcher do
  describe '#call' do
    context 'when phrases are present' do
      let(:row1) { { 'row' => { 'Prompt' => 'phrase1, phrase2, phrase3' } } }
      let(:row2) { { 'row' => { 'Prompt' => 'phrase4, phrase5, phrase6' } } }

      before do
        allow_any_instance_of(DatasetsClient).to receive(:request).and_return(
          'rows' => [row1, row2],
          'num_rows_total' => 100
        )
      end

      it 'creates phrases' do
        expect { described_class.new.call }.to have_enqueued_job(PhraseBatchesCreationJob).with(row1)
                                                                                          .on_queue('test_default')
                                                                                          .exactly(:once)
        expect { described_class.new.call }.to have_enqueued_job(PhraseBatchesCreationJob).with(row2)
                                                                                          .on_queue('test_default')
                                                                                          .exactly(:once)
      end
    end

    context 'when phrases are not present' do
      before do
        allow_any_instance_of(DatasetsClient).to receive(:request).and_return(
          'rows' => [],
          'num_rows_total' => 100
        )
      end

      it 'does not create phrases' do
        expect { described_class.new.call }.not_to have_enqueued_job(PhraseBatchesCreationJob)
      end
    end
  end
end
