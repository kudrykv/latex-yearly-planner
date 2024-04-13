# frozen_string_literal: true

RSpec.describe LatexYearlyPlanner::TeX::TabularX do
  context 'with sample data' do
    subject(:tabularx) { build(:sample_tabularx_with_custom_formatting).to_s }

    let(:expected) { build(:sample_compiled_with_custom_formatting) }

    it { is_expected.to eq(expected) }
  end
end
