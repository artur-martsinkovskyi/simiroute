# frozen_string_literal: true

shared_examples 'parses file with extension' do |extension|
  context "for #{extension} files" do
    let(:file) do
      double(
        path: "double.#{extension}",
        read: ''
      )
    end
    let(:double_strategy) { double(extension.capitalize, call: []) }

    before do
      allow(
        eval("Geo::Data::Strategies::#{extension.capitalize}")
      ).to receive(:new).and_return(
        double_strategy
      )
    end

    it 'calls proper strategy' do
      expect(double_strategy).to receive(:call)
      subject.call
    end
  end
end
