# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DatasetsClient do
  subject { described_class.new }

  context 'when request is successful' do
    let(:responce_body) do
      { 'rows' => [
        { 'Prompt' => 'test1, test2' }
      ] }
    end
    let(:response) { instance_double(Net::HTTPResponse, body: responce_body.to_json) }

    before do
      allow_any_instance_of(Net::HTTP).to receive(:request).and_return(response)
    end

    it 'return parsed response' do
      expect(subject.request).to eq responce_body
    end
  end

  context 'when request is with errors' do
    before do
      allow(Net::HTTP).to receive(:get_response).and_return(nil)
    end

    it 'returns logger with error' do
      expect(subject.request[0].class).to eq ActiveSupport::Logger
      expect(subject.request[0].error).to eq true
    end
  end
end
