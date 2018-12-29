# frozen_string_literal: true

require 'geo/data/parser'
require 'geo/data/constants'
require_relative 'parses_files_with_extension_examples'

describe Geo::Data::Parser do
  subject(:parser_call_result) { described_class.new(file).call }

  describe '#call' do
    context 'with valid file extension' do
      include_examples 'parses file with extension', 'gpx'
      include_examples 'parses file with extension', 'kml'
    end

    context 'with unknown mime type' do
      let(:file) do
        double(
          path: 'double.txt',
          read: ''
        )
      end

      it 'raises an error' do
        expect { parser_call_result }
          .to raise_error(Geo::Data::Exceptions::UnknownMimeTypeError)
      end
    end
  end
end
