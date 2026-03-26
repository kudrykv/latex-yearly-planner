# frozen_string_literal: true

RSpec.describe LYP::Entities::Calendar::Month do
  describe "#initialize" do
    it "creates a new month object" do
      month = make_month("2026-03")
      expect(month.day).to eq(make_day("2026-03-01"))
      expect(month.weekday_start).to eq(:monday)
    end
  end

  describe "#id" do
    it "returns month- prefixed date id" do
      expect(make_month("2026-03").id).to eq("month-2026-03-01")
      expect(make_month("2026-12").id).to eq("month-2026-12-01")
    end
  end

  describe "#name" do
    it "returns lowercase month name" do
      expect(make_month("2026-03").name).to eq("march")
      expect(make_month("2026-12").name).to eq("december")
    end
  end

  describe "#quarter" do
    it "returns quarter for the month" do
      expect(make_month("2026-03").quarter).to eq(make_quarter("2026-01-01"))
      expect(make_month("2026-04").quarter).to eq(make_quarter("2026-04-01"))
      expect(make_month("2026-12").quarter).to eq(make_quarter("2026-10-01"))
    end
  end
end
