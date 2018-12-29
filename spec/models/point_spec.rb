# frozen_string_literal: true

require 'rails_helper'

describe Point do
  it 'factory is valid' do
    expect(build(:point)).to be_valid
  end
end
