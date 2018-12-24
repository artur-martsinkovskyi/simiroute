require "rails_helper"

describe PointBlueprint do
  let(:view) { :default }
  let(:point) { build_stubbed(:point) }
  subject { described_class.render_as_hash(point, view: view) }

  it "renders fields" do
    expect(subject[:id]).to eq(point.id)
  end

  it "renders lat" do
    expect(subject[:lat]).to eq(point.lat)
  end

  it "renders lng" do
    expect(subject[:lng]).to eq(point.lng)
  end

  context "full view" do
    let(:view) { :full }

    it "renders altitude" do
      expect(subject[:altitude]).to eq(point.altitude)
    end

    it "renders tracked_at" do
      expect(subject[:tracked_at]).to eq(point.tracked_at)
    end
  end
end
