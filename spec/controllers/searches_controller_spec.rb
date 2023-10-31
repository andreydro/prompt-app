# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchesController do
  describe 'GET index' do
    let(:phrase1) { create(:phrase) }
    let(:phrase2) { create(:phrase) }
    let(:prased_response) { JSON.parse(response.body) }

    context 'when results are present' do
      let(:expected_response) do
        [{ 'id' => phrase1.id, 'value' => phrase1.value }, { 'id' => phrase2.id, 'value' => phrase2.value }]
      end

      before do
        allow_any_instance_of(Elasticsearch::Model::Response::Response).to receive(:records).and_return(
          [phrase1, phrase2]
        )
      end

      it 'returns a successful response' do
        get :index, params: { query: 'test' }

        expect(response).to be_successful
        expect(prased_response).to eq(expected_response)
      end
    end

    context 'when results are not present' do
      let(:expected_response) { { 'error' => 'No results found' } }

      it 'returns a successful response' do
        get :index, params: { query: 'test' }

        expect(response).to be_successful
        expect(prased_response).to eq(expected_response)
      end
    end
  end
end
