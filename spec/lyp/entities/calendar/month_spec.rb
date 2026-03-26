# frozen_string_literal: true

RSpec.describe LYP::Entities::Calendar::Month do
  describe "#initialize" do
    it "creates a new month object" do
      month = make_month("2026-03")
      expect(month.day).to eq(make_day("2026-03-01"))
      expect(month.weekday_start).to eq(:monday)
    end
  end
end
