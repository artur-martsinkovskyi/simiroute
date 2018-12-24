require "rails_helper"

describe TrackBlueprint do
  let(:view) { :default }
  let(:track) { build_stubbed(:track) }

  subject { described_class.render_as_hash(track, view: view) }

  it "renders fields" do
    expect(subject[:id]).to eq(track.id)
    expect(subject[:uuid]).to eq(track.uuid)
  end

  context "minimal view" do
    let(:view) { :minimal }

    it "renders points" do
      expect(subject[:points]).to eq(
        PointBlueprint.render_as_hash(
          track.points
        )
      )
    end
  end

  context "full view" do
    let(:view) { :full }

    it "renders track_attachment" do
      expect(subject[:track_attachment]).to eq(
        track.track_attachment
      )
    end

    it "renders points" do
      expect(subject[:points]).to eq(
        PointBlueprint.render_as_hash(
          track.points,
          view: view
        )
      )
    end
  end
end
