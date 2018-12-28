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

  context ".name" do
    let(:uuid)  { "uuid" }
    let(:file_name) { "sample.gpx" }
    let(:track) { create(:track) }
    subject { track.name }
    before do
      track.update(uuid: uuid)
    end

    it "is composed of file name and uuid" do
      expect(subject).to eq("#{file_name} - #{uuid}")
    end
  end
end
