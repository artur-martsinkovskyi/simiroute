# frozen_string_literal: true

require 'rails_helper'

describe User do
  it 'factory is valid' do
    expect(build(:user)).to be_valid
  end
end
