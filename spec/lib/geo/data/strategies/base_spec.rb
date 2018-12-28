require 'geo/data/strategies/base'
require 'geo/data/exceptions/parse_error'

describe Geo::Data::Strategies::Base do
  context "#call" do
    let(:content_double) { double("ContentDouble") }
    subject { mock_child.new(content_double).call }

    context "when retrieve data works" do
      let(:mock_child) do
        Class.new(described_class) do
          def retrieve_data
            content
          end
        end
      end

      it "returns retreive data result" do
        expect(subject).to eq(
          content_double
        )
      end
    end

    context "when retrieve data drops an exception" do
      let(:mock_child) do
        Class.new(described_class) do
          def retrieve_data
            raise StandardError, "fake error info"
          end
        end
      end

      it "reraises exception with custom" do
        expect { subject }.to raise_error(
          Geo::Data::Exceptions::ParseError,
          Geo::Data::Exceptions::ParseError::MESSAGE
        )
      end
    end
  end

  context ".can_process?" do
    let(:mock_child) do
      Class.new(described_class) do
        def self.extension
          "gpx"
        end
      end
    end

    context "with matching extension" do
      it "returns true" do
        expect(mock_child.can_process?("gpx")).to be true
      end
    end

    context "with mismatching extension" do
      it "returns false" do
        expect(mock_child.can_process?("ppt")).to be false
      end
    end
  end
end
