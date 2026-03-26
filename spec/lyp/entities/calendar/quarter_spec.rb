# frozen_string_literal: true

RSpec.describe LYP::Entities::Calendar::Quarter do
  describe "#initialize" do
    it "creates a quarter from any day in that quarter" do
      quarter = make_quarter("2026-03-15")
      expect(quarter.day).to eq(make_day("2026-01-01"))
      expect(quarter.weekday_start).to eq(:monday)
    end
  end

  describe "#id" do
    it "returns quarter- prefixed year and number" do
      expect(make_quarter("2026-01-01").id).to eq("quarter-2026-1")
      expect(make_quarter("2026-04-01").id).to eq("quarter-2026-2")
      expect(make_quarter("2026-07-01").id).to eq("quarter-2026-3")
      expect(make_quarter("2026-10-01").id).to eq("quarter-2026-4")
    end
  end

  describe "#number" do
    it "returns quarter number 1-4" do
      expect(make_quarter("2026-01-01").number).to eq(1)
      expect(make_quarter("2026-04-01").number).to eq(2)
      expect(make_quarter("2026-07-01").number).to eq(3)
      expect(make_quarter("2026-10-01").number).to eq(4)
    end
  end

  describe "#months" do
    it "returns three months for Q1" do
      expect(make_quarter("2026-01-01").months).to eq(
        [make_month("2026-01"), make_month("2026-02"), make_month("2026-03")]
      )

      expect(make_quarter("2026-10-01").months).to eq(
        [make_month("2026-10"), make_month("2026-11"), make_month("2026-12")]
      )
    end
  end

  describe "#<=>" do
    it "compares quarters by their day" do
      expect(make_quarter("2026-01-01") <=> make_quarter("2026-04-01")).to eq(-1)
      expect(make_quarter("2026-01-01") <=> make_quarter("2026-01-01", weekday_start: :monday)).to eq(0)
      expect(make_quarter("2026-04-01") <=> make_quarter("2026-01-01")).to eq(1)
    end

    it "raises when other is not a Quarter" do
      expect { make_quarter("2026-01-01") <=> make_day("2026-01-01") }
        .to raise_error(ArgumentError, "must be Quarter")
    end

    it "raises when weekday_start differs" do
      expect { make_quarter("2026-01-01") <=> make_quarter("2026-01-01", weekday_start: :sunday) }
        .to raise_error(ArgumentError, "weekday start must match")
    end
  end
end
