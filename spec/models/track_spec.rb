require "rails_helper"

describe Track do
  it "factory is valid" do
    expect(build(:track)).to be_valid
  end

  it "is created with uuid" do
    expect(create(:track).uuid).to be_present
  end

  it "is created with points by factory" do
    expect(create(:track).points).to be_any
  end
end
