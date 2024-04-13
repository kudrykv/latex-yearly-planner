# frozen_string_literal: true

RSpec.describe LatexYearlyPlanner::TeX::TabularX do
  context 'with sample data' do
    subject(:tabularx) { build(:sample_tabularx_with_custom_formatting).to_s }

    let(:expected) { build(:sample_compiled_with_custom_formatting) }

    it { is_expected.to eq(expected) }
  end

  context 'with crafting by hand' do
    subject(:tabularx) { described_class.new }

    let(:rows) do
      [
        LatexYearlyPlanner::TeX::TableRow.new(%w[a b c]),
        LatexYearlyPlanner::TeX::TableRow.new(%w[d e f])
      ]
    end

    let(:one_more_row) { LatexYearlyPlanner::TeX::TableRow.new(%w[g h i]) }
    let(:expected) do
      <<~LATEX.strip
        {\\renewcommand{\\arraystretch}{1}%
        \\setlength{\\tabcolsep}{0pt}%
        \\begin{tabularx}{\\linewidth}{Y|YY|}
          a & b & c\\\\
          d & e & f\\\\
          g & h & i\\\\
        \\end{tabularx}}
      LATEX
    end

    it 'uses add_rows and add_row and builds its own format' do
      tabularx.add_rows(rows)
      tabularx.add_row(one_more_row)

      tabularx.add_vertical_line(1)
      tabularx.add_vertical_line(3)

      expect(tabularx.to_s).to eq(expected)
    end
  end
end
