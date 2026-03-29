# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Components::MonthsMenu do
  let(:i18n) { class_double(I18n, "i18n") }

  before do
    translations = {
      "months.short.january" => "Jan",
      "months.short.february" => "Feb",
      "months.short.march" => "Mar",
      "months.short.april" => "Apr"
    }

    allow(i18n).to receive(:t) { |key| translations.fetch(key) }
  end

  describe "#generate" do
    let(:expected) do
      <<~TYPST.strip
        table(
          stroke: (x, y) => (left: regular_stroke, right: regular_stroke, bottom: regular_stroke),
          columns: (1fr, 1fr, 1fr, 1fr),
          rows: 1fr,
          align: horizon + center,

          table.cell([Jan]),
        table.cell(fill: black, text(white)[Feb]),
        table.cell([#padded_link(<#{make_month("2026-03").id}>)[Mar]]),
        table.cell(fill: black, text(white)[#padded_link(<#{make_month("2026-04").id}>)[Apr]])
        )
      TYPST
    end

    it "renders plain, highlighted, linked, and highlighted+linked months" do
      jan, feb, mar, apr = %w[01 02 03 04].map { |m| make_month("2026-#{m}") }

      manifest = LYP::Planners::MOS::Manifest.new
      manifest.register_source(mar.id)
      manifest.register_source(apr.id)

      menu = described_class.new(i18n:, manifest:, range: jan..apr)
      menu.highlight([feb, apr])

      expect(menu.generate).to eq(expected)
    end
  end
end
