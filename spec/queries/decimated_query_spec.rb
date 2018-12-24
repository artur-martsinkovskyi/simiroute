require 'rails_helper'

describe DecimatedQuery do
  context "#call" do
    subject { described_class.new(records).call }
    before do
      stub_const("#{described_class}::UNDECIMATABLE_LIMIT", 3)
    end

    context "with point count less than undecimatable limit" do
      let(:records) { Point.none }

      it "returns points unchanged" do
        expect(subject).to eq(records)
      end
    end

    context "with more points that undecimatable limit" do
      context do
        let(:track) do
          record = build(:track, points_attributes: attributes_for_list(:point, 9))
          record.save
          record
        end
        let(:records) { track.points }

        it "returns decimated number of points" do
          expect(subject.size).to eq(3)
        end
      end

      context do
        let(:track) { create(:track) }
        let(:records) { track.points }

        it "returns decimated points" do
          expect(subject).to eq([records.last])
        end
      end
    end
  end
end
