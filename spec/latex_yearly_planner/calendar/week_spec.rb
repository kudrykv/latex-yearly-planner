# frozen_string_literal: true

require 'rspec'

Month = LatexYearlyPlanner::Calendar::Month

RSpec.describe LatexYearlyPlanner::Calendar::Week do
  subject(:week) { described_class.new(weekday_start:, days:) }

  let(:weekday_start) { :monday }

  context 'when a week is just a week' do
    let(:days) { (14..20).map { |day| Day.new(weekday_start:, moment: Date.new(year, month, day)) } }
    let(:year) { 2024 }
    let(:month) { 10 }

    describe '#id' do
      it { expect(week.id).to eq('week-42-2024-10') }
    end

    describe '#ids' do
      it { expect(week.ids).to eq(%w[week-42-2024-10]) }
    end

    describe '#number' do
      it { expect(week.number).to eq(42) }
    end

    describe '#months' do
      let(:months) { [Month.new(weekday_start:, year:, month:)] }

      it { expect(week.months).to eq(months) }
    end
  end

  context "when a month's days start midweek, and previous month's days are nils" do
    let(:days) do
      ([nil] * 4).concat((1..3).map { |day| Day.new(weekday_start:, moment: Date.new(year, month, day)) })
    end
    let(:year) { 2024 }
    let(:month) { 11 }

    describe '#id' do
      it { expect(week.id).to eq('week-44-2024-11') }
    end

    describe '#ids' do
      it { expect(week.ids).to eq(%w[week-44-2024-11]) }
    end

    describe '#number' do
      it { expect(week.number).to eq(44) }
    end

    describe '#months' do
      let(:months) { [Month.new(weekday_start:, year:, month:)] }

      it { expect(week.months).to eq(months) }
    end
  end

  context "when a month's days end midweek, and next month's days are nils" do
    let(:days) do
      (28..31).map { |day| Day.new(weekday_start:, moment: Date.new(year, month, day)) }.concat([nil] * 3)
    end
    let(:year) { 2024 }
    let(:month) { 10 }

    describe '#id' do
      it { expect(week.id).to eq('week-44-2024-10') }
    end

    describe '#ids' do
      it { expect(week.ids).to eq(%w[week-44-2024-10]) }
    end

    describe '#number' do
      it { expect(week.number).to eq(44) }
    end

    describe '#months' do
      let(:months) { [Month.new(weekday_start:, year:, month:)] }

      it { expect(week.months).to eq(months) }
    end
  end

  context 'when a weeks spans over two months' do
    let(:days) do
      (28..31).map { |day| Day.new(weekday_start:, moment: Date.new(year, 10, day)) }
              .concat((1..3).map { |day| Day.new(weekday_start:, moment: Date.new(year, 11, day)) })
    end
    let(:year) { 2024 }

    describe '#id' do
      it { expect(week.id).to eq('week-44-2024-10') }
    end

    describe '#ids' do
      it { expect(week.ids).to eq(%w[week-44-2024-10 week-44-2024-11]) }
    end

    describe '#number' do
      it { expect(week.number).to eq(44) }
    end

    describe '#months' do
      let(:months) { [Month.new(weekday_start:, year:, month: 10), Month.new(weekday_start:, year:, month: 11)] }

      it { expect(week.months).to eq(months) }
    end
  end

  context 'when a week starts on a Sunday' do
    let(:weekday_start) { :sunday }

    let(:days) { (13..19).map { |day| Day.new(weekday_start:, moment: Date.new(2024, 10, day)) } }

    describe '#number' do
      it { expect(week.number).to eq(42) }
    end
  end

  describe '#==' do
    let(:days) { (14..20).map { |day| Day.new(weekday_start:, moment: Date.new(2024, 10, day)) } }
    let(:days_not_same) { (7..13).map { |day| Day.new(weekday_start:, moment: Date.new(2024, 10, day)) } }

    let(:other_same) { described_class.new(weekday_start:, days:) }
    let(:other_not_same_days) { described_class.new(weekday_start:, days: days_not_same) }
    let(:other_not_same_weekday) { described_class.new(weekday_start: :sunday, days:) }

    it { expect(week).to eq(other_same) }
    it { expect(week).not_to eq(other_not_same_days) }
    it { expect(week).not_to eq(other_not_same_weekday) }
    it { expect(week).not_to eq('other') }
  end
end
