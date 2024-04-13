# frozen_string_literal: true

RSpec.describe LatexYearlyPlanner::TeX::TabularX do
  context 'with sample data' do
    subject(:sample_tabularx) { build(:sample_tabularx).to_s }

    let(:expected) { build(:sample_compiled) }

    it { is_expected.to eq(expected) }
  end
end
