# frozen_string_literal: true

RSpec.describe LYP::Entities::Calendar::Week do
  describe "#initialize" do
    context "week starts on Monday" do
      let(:weekday_start) { :monday }

      it "creates a week object" do
        week = make_week("2026-03-15", weekday_start:)
        expect(week.day).to eq(make_day("2026-03-09", weekday_start:))
        expect(week.weekday_start).to eq(weekday_start)
      end
    end

    context "#weekday starts on sunday" do
      let(:weekday_start) { :sunday }

      it "creates a week object" do
        week = make_week("2026-03-15", weekday_start:)
        expect(week.day).to eq(make_day("2026-03-15", weekday_start:))
        expect(week.weekday_start).to eq(weekday_start)
      end
    end
  end

  describe "#id" do
    it "returns week id" do
      expect(make_week("2026-03-15").id).to eq("2026W11")
      expect(make_week("2025-12-29").id).to eq("2026W01")
      expect(make_week("2026-12-28").id).to eq("2026W53")
      expect(make_week("2027-01-03").id).to eq("2026W53")
    end
  end

  describe "#number" do
    it "returns a week number" do
      expect(make_week("2026-03-15").number).to eq(11)
      expect(make_week("2025-12-29").number).to eq(1)
      expect(make_week("2026-12-28").number).to eq(53)
      expect(make_week("2027-01-03").number).to eq(53)
    end
  end

  describe "#days" do
    it "returns days that week consists of" do
      expect(make_week("2026-03-15").days).to eq((0..6).map { |i| make_day("2026-03-09") + i })
    end
  end

  describe "#in_months" do
    it "returns months that this week is in" do
      expect(make_week("2026-03-15").in_months).to eq([make_month("2026-03")])
      expect(make_week("2026-03-30").in_months).to eq([make_month("2026-03"), make_month("2026-04")])
      expect(make_week("2026-04-04").in_months).to eq([make_month("2026-03"), make_month("2026-04")])
    end
  end

  describe "#in_quarters" do
    it "returns quarters that this week is in" do
      expect(make_week("2026-03-15").in_quarters).to eq([make_quarter("2026-03-01")])
      expect(make_week("2026-03-31").in_quarters).to eq([make_quarter("2026-03-01"), make_quarter("2026-04-01")])
      expect(make_week("2026-04-03").in_quarters).to eq([make_quarter("2026-03-01"), make_quarter("2026-04-01")])
    end
  end
end
