# frozen_string_literal: true

RSpec.describe LatexYearlyPlanner::TeX::TableFormatting do
  describe '#to_s' do
    it 'returns the formatting' do
      expect(described_class.new('lll').to_s).to eq 'lll'
    end
  end
end
