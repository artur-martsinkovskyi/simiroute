require "rails_helper"

describe ApplicationHelper do
  include ApplicationHelper

  context "#display_errors" do
    context "with string passed" do
      let(:attributes) do
        [
          :field,
          "is invalid"
        ]
      end

      it "builds an error string" do
        expect(
          display_errors(*attributes)
        ).to eq("is invalid")
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
        expect(
          display_errors(*attributes)
        ).to eq("Field is invalid, is really invalid.")
      end
    end
  end
end
