# frozen_string_literal: true

RSpec.describe LYP::Entities::Calendar::Day do
  describe "#initialize" do
    it "accepts a Date and weekday_start" do
      day = make_day("2026-03-15")
      expect(day.day).to eq(Date.new(2026, 3, 15))
      expect(day.weekday_start).to eq(:monday)
    end
  end

  describe "#id" do
    it "formats as YYYY-MM-DD" do
      expect(make_day("2026-02-03").id).to eq("2026-02-03")
    end
  end

  describe "#beginning_of_month" do
    it "returns first day of month" do
      expect(make_day("2026-03-15").beginning_of_month).to eq(make_day("2026-03-01"))
      expect(make_day("2026-03-01").beginning_of_month).to eq(make_day("2026-03-01"))
    end
  end

  describe "#end_of_month" do
    it "returns last day of month" do
      expect(make_day("2026-03-15").end_of_month).to eq(make_day("2026-03-31"))
      expect(make_day("2026-03-31").end_of_month).to eq(make_day("2026-03-31"))
    end
  end

  describe "#next_month" do
    it "returns corresponding day of next month" do
      expect(make_day("2026-03-15").next_month).to eq(make_day("2026-04-15"))
      expect(make_day("2026-03-31").next_month).to eq(make_day("2026-04-30"))
    end
  end

  describe "#month" do
    it "returns month object" do
      expect(make_day("2026-03-15").month).to eq(make_month("2026-03"))
    end
  end

  describe "#quarter" do
    it "returns quarter object" do
      expect(make_day("2026-03-15").quarter).to eq(make_quarter("2026-03-01"))
    end
  end

  describe "#week" do
    it "returns week object" do
      expect(make_day("2026-03-15").week).to eq(make_week("2026-03-15"))
    end
  end

  describe "#quarter_number" do
    it "returns quarter number" do
      expect(make_day("2026-03-15").quarter_number).to eq(1)
      expect(make_day("2026-04-15").quarter_number).to eq(2)
    end
  end

  describe "#beginning_of_quarter" do
    it "returns first day of quarter" do
      expect(make_day("2026-03-15").beginning_of_quarter).to eq(make_day("2026-01-01"))
      expect(make_day("2026-04-15").beginning_of_quarter).to eq(make_day("2026-04-01"))
    end
  end

  describe "#next_quarter" do
    it "returns given day + 3 months (staying in month)" do
      expect(make_day("2026-03-31").next_quarter).to eq(make_day("2026-06-30"))
    end
  end

  describe "#beginning_of_week" do
    it "returns first day of week" do
      expect(make_day("2026-03-15").beginning_of_week).to eq(make_day("2026-03-09"))

      weekday_start = :sunday
      expect(make_day("2026-03-15", weekday_start:).beginning_of_week).to eq(make_day("2026-03-15", weekday_start:))
    end
  end

  describe "#end_of_week" do
    it "returns last day of week" do
      expect(make_day("2026-03-15").end_of_week).to eq(make_day("2026-03-15"))

      weekday_start = :sunday
      expect(make_day("2026-03-15", weekday_start:).end_of_week).to eq(make_day("2026-03-21", weekday_start:))
    end
  end

  describe "#month_day" do
    it "returns day of month" do
      expect(make_day("2026-03-15").month_day).to eq(15)
    end
  end

  describe "#weekday_name" do
    it "returns lowercase day name" do
      expect(make_day("2026-03-15").weekday_name).to eq("sunday")
    end
  end

  describe "#+" do
    it "changes the day" do
      expect(make_day("2026-03-29") + 3).to eq(make_day("2026-04-01"))
    end
  end
end
