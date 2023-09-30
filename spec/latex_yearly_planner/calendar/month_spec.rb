# frozen_string_literal: true

require 'rspec'

Week = LatexYearlyPlanner::Calendar::Week
Quarter = LatexYearlyPlanner::Calendar::Quarter
Day = LatexYearlyPlanner::Calendar::Day

RSpec.describe LatexYearlyPlanner::Calendar::Month do
  let(:date) { Date.new(2023, 9, 30).beginning_of_month }
  let(:weekday_start) { :monday }

  context 'when calling month methods' do
    subject(:month) { described_class.new(date, weekday_start:) }

    let(:another_same_month) { described_class.new(date, weekday_start:) }
    let(:quarter) { Quarter.new(date.beginning_of_quarter, weekday_start:) }


    let :weeks do
      [
        Week.new([nil, nil, nil, nil] + (1..3).map { |day| Date.new(2023, 9, day) }, weekday_start:),
        Week.new((4..10).map { |day| Date.new(2023, 9, day) }, weekday_start:),
        Week.new((11..17).map { |day| Date.new(2023, 9, day) }, weekday_start:),
        Week.new((18..24).map { |day| Date.new(2023, 9, day) }, weekday_start:),
        Week.new((25..30).map { |day| Date.new(2023, 9, day) } + [nil], weekday_start:)
      ]
    end

    it { expect(month).to eq(another_same_month) }
    it { expect(month.name).to eq('September') }
    it { expect(month.mon).to eq(9) }
    it { expect(month.quarter).to eq(quarter) }
    it { expect(month.year).to eq(2023) }
    it { expect(month.reference).to eq('2023-September') }
    it { expect(month.weekdays_one_letter).to eq(%w[M T W T F S S]) }
    it { expect(month.weekdays_short).to eq(%w[Mon Tue Wed Thu Fri Sat Sun]) }
    it { expect(month.weeks).to eq(weeks) }
  end
end
