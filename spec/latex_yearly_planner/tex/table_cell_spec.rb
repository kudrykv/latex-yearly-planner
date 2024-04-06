# frozen_string_literal: true

RSpec.describe LatexYearlyPlanner::TeX::TableCell do
  describe '#to_s' do
    context 'when the cell is empty' do
      it 'returns an empty cell' do
        expect(described_class.new.to_s).to eq('')
      end
    end

    context 'when the cell has content' do
      let(:content) { 'content' }

      it 'returns the cell with content' do
        expect(described_class.new(content).to_s).to eq(content)
      end
    end
  end
end
