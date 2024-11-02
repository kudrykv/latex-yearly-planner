# frozen_string_literal: true

require 'rspec'

Week = LatexYearlyPlanner::Calendar::Week
Quarter = LatexYearlyPlanner::Calendar::Quarter
Day = LatexYearlyPlanner::Calendar::Day

RSpec.describe LatexYearlyPlanner::Calendar::Month do
  subject(:month) { described_class.new(month: month_number, year:, weekday_start:) }

  let(:month_number) { 9 }
  let(:year) { 2023 }
  let(:date) { Date.new(year, month_number, 1).next_day(-1) }
  let(:weekday_start) { :monday }

  describe '#weeks' do
    let :weeks do
      [
        Week.new(days: [nil, nil, nil, nil] + (1..3).map do |day|
                                                Day.new(weekday_start:, moment: date.next_day(day))
                                              end, weekday_start:),
        Week.new(days: (4..10).map { |day| Day.new(weekday_start:, moment: date.next_day(day)) }, weekday_start:),
        Week.new(days: (11..17).map { |day| Day.new(weekday_start:, moment: date.next_day(day)) }, weekday_start:),
        Week.new(days: (18..24).map { |day| Day.new(weekday_start:, moment: date.next_day(day)) }, weekday_start:),
        Week.new(days: (25..30).map { |day|
                         Day.new(weekday_start:, moment: date.next_day(day))
                       } + [nil], weekday_start:)
      ]
    end

    it { expect(month.weeks).to eq(weeks) }
  end

  describe '#id' do
    it { expect(month.id).to eq('2023-09') }
  end

  describe '#name' do
    it { expect(month.name).to eq('September') }
  end

  describe '#year' do
    it { expect(month.year).to eq(year) }
  end

  describe '#mon' do
    it { expect(month.mon).to eq(month_number) }
  end

  describe '#quarter' do
    let(:quarter) { Quarter.new(weekday_start:, year:, number: 3) }

    it { expect(month.quarter).to eq(quarter) }
  end

  describe '#==' do
    let(:other) { described_class.new(month: month_number, year:, weekday_start:) }

    it { expect(month).to eq(other) }
  end

  describe '#<=>' do
    let(:other) { described_class.new(month: month_number, year:, weekday_start:) }

    it { expect(month <=> other).to eq(0) }
    it { expect(month <=> 'not a month').to be_nil }
  end
end
