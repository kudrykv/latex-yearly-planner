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
  end
end
