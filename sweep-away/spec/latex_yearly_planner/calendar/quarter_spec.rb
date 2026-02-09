# frozen_string_literal: true

require 'rspec'

RSpec.describe LatexYearlyPlanner::Calendar::Quarter do
  subject(:quarter) { described_class.new(weekday_start:, year:, number:) }

  let(:weekday_start) { :monday }
  let(:year) { 2024 }
  let(:number) { 2 }

  describe '#id' do
    it { expect(quarter.id).to eq('quarter-2024-2') }
  end

  describe '#months' do
    let(:months) do
      [
        LatexYearlyPlanner::Calendar::Month.new(weekday_start:, year:, month: 4),
        LatexYearlyPlanner::Calendar::Month.new(weekday_start:, year:, month: 5),
        LatexYearlyPlanner::Calendar::Month.new(weekday_start:, year:, month: 6)
      ]
    end

    it { expect(quarter.months).to eq(months) }
  end

  describe '#==' do
    let(:other) { described_class.new(weekday_start:, year:, number:) }

    it { expect(quarter == other).to be(true) }
  end
end
