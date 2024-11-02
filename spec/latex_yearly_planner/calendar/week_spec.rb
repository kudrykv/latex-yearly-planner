# frozen_string_literal: true

require 'rspec'

Day = LatexYearlyPlanner::Calendar::Day

RSpec.describe LatexYearlyPlanner::Calendar::Week do
  subject(:week) { described_class.new(weekday_start:, days:) }

  let(:weekday_start) { 1 }

  context 'when a week is just a week' do
    let(:days) { (14..20).map { |day| Day.new(weekday_start:, moment: Date.new(2024, 10, day)) } }

    describe '#id' do
      it { expect(week.id).to eq('week-42-2024-10') }
    end

    describe '#ids' do
      it { expect(week.ids).to eq(%w[week-42-2024-10]) }
    end
  end

  context "when a month's days start midweek, and previous month's days are nils" do
    let(:days) do
      ([nil] * 4).concat((1..3).map { |day| Day.new(weekday_start:, moment: Date.new(2024, 11, day)) })
    end

    describe '#id' do
      it { expect(week.id).to eq('week-44-2024-11') }
    end

    describe '#ids' do
      it { expect(week.ids).to eq(%w[week-44-2024-11]) }
    end
  end

  context "when a month's days end midweek, and next month's days are nils" do
    let(:days) do
      (28..31).map { |day| Day.new(weekday_start:, moment: Date.new(2024, 10, day)) }.concat([nil] * 3)
    end

    describe '#id' do
      it { expect(week.id).to eq('week-44-2024-10') }
    end

    describe '#ids' do
      it { expect(week.ids).to eq(%w[week-44-2024-10]) }
    end
  end

  context 'when a weeks spans over two months' do
    let(:days) do
      (28..31).map { |day| Day.new(weekday_start:, moment: Date.new(2024, 10, day)) }
              .concat((1..3).map { |day| Day.new(weekday_start:, moment: Date.new(2024, 11, day)) })
    end

    describe '#id' do
      it { expect(week.id).to eq('week-44-2024-10') }
    end

    describe '#ids' do
      it { expect(week.ids).to eq(%w[week-44-2024-10 week-44-2024-11]) }
    end
  end
end
