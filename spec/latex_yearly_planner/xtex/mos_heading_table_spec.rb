# frozen_string_literal: true

RSpec.describe LatexYearlyPlanner::XTeX::MosHeadingTable do
  describe '#to_s' do
    let(:mos_heading_table) { build(:sample_mos_heading_table) }
    let(:compiled) { build(:sample_mos_heading_table_compiled) }

    it 'builds a heading table' do
      expect(mos_heading_table.to_s).to eq(compiled)
    end
  end
end
