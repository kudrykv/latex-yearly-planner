# frozen_string_literal: true

require 'rspec'

Week = LatexYearlyPlanner::Calendar::Week
Quarter = LatexYearlyPlanner::Calendar::Quarter
Day = LatexYearlyPlanner::Calendar::Day

RSpec.describe LatexYearlyPlanner::Calendar::Month do
  let(:month_number) { 9 }
  let(:year) { 2023 }
  let(:weekday_start) { :monday }

  context 'when calling month methods' do
    subject(:month) { described_class.new(month: month_number, year:, weekday_start:) }

    let(:another_same_month) { described_class.new(month: month_number, year:, weekday_start:) }
    let(:quarter) { Quarter.new(weekday_start:, year:, number: 3) }

    let :weeks do
      [
        Week.new(days: [nil, nil, nil, nil] + (1..3).map { |day| Day.new(year:, month: month_number, day:, weekday_start:) }, weekday_start:),
        Week.new(days: (4..10).map { |day| Day.new(year:, month: month_number, day:, weekday_start:) }, weekday_start:),
        Week.new(days: (11..17).map { |day| Day.new(year:, month: month_number, day:, weekday_start:) }, weekday_start:),
        Week.new(days: (18..24).map { |day| Day.new(year:, month: month_number, day:, weekday_start:) }, weekday_start:),
        Week.new(days: (25..30).map { |day| Day.new(year:, month: month_number, day:, weekday_start:) } + [nil], weekday_start:)
      ]
    end

    it { expect(month).to eq(another_same_month) }
    it { expect(month.name).to eq('September') }
    it { expect(month.mon).to eq(9) }
    it { expect(month.quarter).to eq(quarter) }
    it { expect(month.year).to eq(2023) }
    it { expect(month.weeks).to eq(weeks) }
  end
end
