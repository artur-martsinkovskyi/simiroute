require "rails_helper"

describe ApplicationHelper do
  include ApplicationHelper

  subject { display_errors(*attributes) }

  context "#display_errors" do
    context "with string passed" do
      let(:attributes) do
        [
          :field,
          "is invalid"
        ]
      end

      it "builds an error string" do
        expect(subject).to eq("is invalid")
      end
    end

    context "with array passed" do
     let(:attributes) do
        [
          :field,
          [
            "is invalid",
            "is really invalid"
          ]
        ]
      end

      it "builds an error string" do
        expect(subject).to eq("Field is invalid, is really invalid.")
      end
    end
  end

  context "with errant datatype passed" do
    let(:attributes) { [:field, nil] }

    it "raises an error" do
      expect { subject }.to raise_error(ArgumentError)
    end
  end
end
