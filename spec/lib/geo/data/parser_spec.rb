# frozen_string_literal: true

require 'geo/data/parser'
require 'geo/data/exceptions/unknown_extension_error'
require_relative 'parses_files_with_extension_examples'

describe Geo::Data::Parser do
  subject { described_class.new(file) }

  context '#call' do
    context 'with valid file extension' do
      include_examples 'parses file with extension', 'gpx'
      include_examples 'parses file with extension', 'kml'
      include_examples 'parses file with extension', 'plt'
    end

    context 'with unknown file extension' do
      let(:file) do
        double(
          path: 'double.wrong',
          read: ''
        )
      end

      it 'raises an error' do
        expect { subject.call }.to raise_error(Geo::Data::Exceptions::UnknownExtensionError)
      end
    end
  end
end
