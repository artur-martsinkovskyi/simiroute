# frozen_string_literal: true

require 'rails_helper'

class DummyBlueprint
  MAXIMAL = :maximal
  MINIMAL = :minimal
  VIEWS = [MAXIMAL, MINIMAL].freeze
end

describe Api::BlueprinterAutoviews do
  subject(:mock_controller) do
    Class.new do
      include Api::BlueprinterAutoviews

      def initialize(view_param)
        @view_param = view_param
      end

      define_method :params do
        {
          view: @view_param.to_s
        }
      end
    end
  end

  context 'with view fallback' do
    let(:view_fallback) { DummyBlueprint::MINIMAL }

    before do
      mock_controller.blueprinter_views_for(
        :dummy,
        view_fallback: view_fallback
      )
    end

    context 'with valid view param passed' do
      let(:view_param) { DummyBlueprint::MAXIMAL }

      it 'returns its value' do
        expect(mock_controller.new(view_param).view).to eq(view_param)
      end
    end

    context 'with invalid view param passed' do
      let(:view_param) { :invalid }

      it 'returns default value' do
        expect(mock_controller.new(view_param).view).to eq(view_fallback)
      end
    end
  end

  context 'without view fallback' do
    before do
      mock_controller.blueprinter_views_for(:dummy)
    end

    context 'with valid view param passed' do
      let(:view_param) { DummyBlueprint::MAXIMAL }

      it 'returns its value' do
        expect(mock_controller.new(view_param).view).to eq(view_param)
      end
    end

    context 'with invalid view param passed' do
      let(:view_param) { :invalid }

      it 'returns default value' do
        expect(mock_controller.new(view_param).view)
          .to eq(described_class::VIEW_FALLBACK)
      end
    end
  end
end
