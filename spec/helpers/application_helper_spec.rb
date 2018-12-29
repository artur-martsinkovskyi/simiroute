# frozen_string_literal: true

require 'rails_helper'

describe ApplicationHelper do
  include described_class

  describe '#display_errors' do
    subject(:display_errors_call) { display_errors(*attributes) }

    context 'with string passed' do
      let(:attributes) do
        [
          :field,
          'is invalid'
        ]
      end

      it 'builds an error string' do
        expect(display_errors_call).to eq('is invalid')
      end
    end

    context 'with array passed' do
      let(:attributes) do
        [
          :field,
          [
            'is invalid',
            'is really invalid'
          ]
        ]
      end

      it 'builds an error string' do
        expect(display_errors_call)
          .to eq('Field is invalid, is really invalid.')
      end
    end

    context 'with errant datatype passed' do
      let(:attributes) { [:field, nil] }

      it 'raises an error' do
        expect { display_errors_call }.to raise_error(ArgumentError)
      end
    end
  end
end
