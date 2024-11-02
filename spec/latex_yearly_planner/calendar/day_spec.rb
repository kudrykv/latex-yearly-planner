# frozen_string_literal: true

require 'rspec'

RSpec.describe LatexYearlyPlanner::Calendar::Day do
  subject(:day) { described_class.new(weekday_start:, moment:) }

  let(:weekday_start) { :monday }
  let(:moment) { Date.new(2024, 11, 7) }

  describe '#id' do
    it { expect(day.id).to eq('day-2024-11-07') }
  end

  describe '#day' do
    it { expect(day.day).to eq(7) }
  end

  describe '#week' do
    let(:week) { LatexYearlyPlanner::Calendar::Week.new(weekday_start:, days:) }
    let(:days) { (4..10).map { |day| described_class.new(weekday_start:, moment: Date.new(2024, 11, day)) } }

    it { expect(day.week).to eq(week) }
  end

  describe '#name' do
    it { expect(day.name).to eq('Thursday') }
  end

  describe '#monday?' do
    let(:monday) { described_class.new(weekday_start:, moment: Date.new(2024, 11, 4)) }
    let(:tuesday) { described_class.new(weekday_start:, moment: Date.new(2024, 11, 5)) }

    it { expect(monday).to be_monday }
    it { expect(tuesday).not_to be_monday }
  end

  describe '#month' do
    let(:month) { LatexYearlyPlanner::Calendar::Month.new(weekday_start:, year: 2024, month: 11) }

    it { expect(day.month).to eq(month) }
  end

  describe '#quarter' do
    let(:quarter) { LatexYearlyPlanner::Calendar::Quarter.new(weekday_start:, year: 2024, number: 4) }

    it { expect(day.quarter).to eq(quarter) }
  end

  describe '#cweek' do
    it { expect(day.cweek).to eq(45) }
  end

  describe '#strftime' do
    it { expect(day.strftime('%Y-%m-%d')).to eq('2024-11-07') }
  end

  describe '#==' do
    let(:other) { described_class.new(weekday_start:, moment: Date.new(2024, 11, 7)) }

    it { expect(day).to eq(other) }
  end
end
