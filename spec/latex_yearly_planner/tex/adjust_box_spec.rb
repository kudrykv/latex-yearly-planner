# frozen_string_literal: true

RSpec.describe LatexYearlyPlanner::TeX::AdjustBox do
  describe '#to_s' do
    it 'returns the LaTeX code for the adjustbox' do
      adjust_box = described_class.new('content', vertical_align: 'b')
      expect(adjust_box.to_s).to eq('\adjustbox{valign=b}{content}')
    end
  end
end
