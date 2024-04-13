# frozen_string_literal: true

RSpec.describe LatexYearlyPlanner::TeX::VerticalPhantom do
  let(:vertical_phantom) { described_class.new('Qy') }

  describe '#to_s' do
    it 'returns the TeX code for a vertical phantom' do
      expect(vertical_phantom.to_s).to eq '\vphantom{Qy}'
    end
  end
end
