# frozen_string_literal: true

require 'rspec'

RSpec.describe LatexYearlyPlanner::TeX::TableRow do
  describe '#to_s' do
    let(:cells) { %w[a b c] }
    let(:row) { described_class.new(cells) }

    context 'when cells only are specified' do
      let(:expected) { 'a & b & c\\\\' }

      it 'returns the cells joined by & and ended with \\\\' do
        expect(row.to_s).to eq(expected)
      end
    end

    context 'when upperlined is true' do
      let(:expected) { "\\hline\na & b & c\\\\" }

      it 'returns the cells joined by & and ended with \\\\ with prepended \\hline' do
        expect(row.upperline.to_s).to eq(expected)
      end
    end

    context 'when underlined is true' do
      let(:expected) { 'a & b & c\\\\\\hline' }

      it 'returns the cells joined by & and ended with \\\\ with appended \\hline' do
        expect(row.underline.to_s).to eq(expected)
      end
    end

    context 'when upperlined and underlined are true' do
      let(:expected) { "\\hline\na & b & c\\\\\\hline" }

      it 'returns the cells joined by & and ended with \\\\ with prepended \\hline and appended \\hline' do
        expect(row.upperline.underline.to_s).to eq(expected)
      end
    end

    context 'when pushing a cell' do
      it 'adds the cell to the cells' do
        expect(row.push('d')).to eq(%w[a b c d])
      end
    end

    context 'when unshifting a cell' do
      it 'adds the cell to the beginning of the cells' do
        expect(row.unshift('d')).to eq(%w[d a b c])
      end
    end

    context 'when size is called' do
      it 'returns the number of cells' do
        expect(row.size).to eq(cells.size)
      end
    end
  end
end
