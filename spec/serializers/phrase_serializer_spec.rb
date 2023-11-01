# frozen_string_literal: true

require 'rails_helper'

describe PhraseSerializer do
  let(:phrase) { create(:phrase) }

  subject { PhraseSerializer.new.serialize(phrase).compact }

  it 'returns the correct keys' do
    expect(subject.keys).to match_array(%w[id value])
  end
end
