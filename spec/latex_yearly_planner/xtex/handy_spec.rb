# frozen_string_literal: true

RSpec.describe LatexYearlyPlanner::XTeX::Handy do
  subject(:handy) { Class.new { extend LatexYearlyPlanner::XTeX::Handy } }

  it { expect(handy.nl).to eq "\n" }
  it { expect(handy.nlnl).to eq "\n\n" }
  it { expect(handy.page_break).to eq '\pagebreak{}' }
  it { expect(handy.horizontal_spring).to eq '\hfill{}' }
  it { expect(handy.vertical_spring).to eq '\vfill{}' }

  context '#adjust_box' do
    let(:content) { 'content' }
    let(:vertical_align) { 't' }
    let(:actual) { handy.adjust_box(content, vertical_align:) }
    let(:expected) { LatexYearlyPlanner::TeX::AdjustBox.new(content, vertical_align:).to_s }

    it { expect(actual).to eq(expected) }
  end
end
