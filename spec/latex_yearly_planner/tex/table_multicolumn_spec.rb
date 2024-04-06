# frozen_string_literal: true

RSpec.describe LatexYearlyPlanner::TeX::TableMulticolumn do
  describe '#to_s' do
    let(:content) { 'content' }
    let(:width) { 2 }
    let(:format) { 'c' }
    let(:multicolumn) { described_class.new(content, width, format:) }
    let(:expected) { "\\multicolumn{#{width}}{#{format}}{#{content}}" }

    it 'returns the multicolumn string' do
      expect(multicolumn.to_s).to eq(expected)
    end
  end
end
