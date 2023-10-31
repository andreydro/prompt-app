require 'rails_helper'

RSpec.describe Phrase, type: :model do
  # validations
  it { is_expected.to validate_presence_of :value }
end
