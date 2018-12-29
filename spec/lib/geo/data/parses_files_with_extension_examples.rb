# frozen_string_literal: true

shared_examples 'parses file with extension' do |extension|
  context "for #{extension} files" do
    let(:file) do
      double(
        path: "double.#{extension}",
        read: ''
      )
    end
    let(:double_strategy) { spy(extension.capitalize) }

    before do
      allow(
        # rubocop: disable Security/Eval
        eval(
          "Geo::Data::Strategies::#{extension.capitalize}",
          nil,
          __FILE__,
          __LINE__ - 3
        )
        # rubocop: enable Security/Eval
      ).to receive(:new).and_return(
        double_strategy
      )
    end

    it 'calls proper strategy' do
      parser_call_result
      expect(double_strategy).to have_received(:call)
    end
  end
end
