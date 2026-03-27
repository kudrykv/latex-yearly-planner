# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Components::QuartersMenu do
  let(:i18n) { class_double(I18n, "i18n") }

  before do
    allow(i18n).to receive(:t).with("quarters.short").and_return("Q")
  end

  describe "#generate" do
    let(:first_quarter) { make_quarter("2026-01-01") }
    let(:second_quarter) { make_quarter("2026-04-01") }
    let(:third_quarter) { make_quarter("2026-07-01") }
    let(:fourth_quarter) { make_quarter("2026-10-01") }

    let(:expected) do
      <<~TYPST.strip
        table(
          stroke: (x, y) => (left: 0.4pt, right: 0.4pt, bottom: 0.4pt),
          columns: (1fr, 1fr, 1fr, 1fr),
          rows: 1fr,
          align: horizon + center,

          table.cell([Q1]),
        table.cell(fill: black, text(white)[Q2]),
        table.cell([#padded_link(<#{third_quarter.id}>)[Q3]]),
        table.cell(fill: black, text(white)[#padded_link(<#{fourth_quarter.id}>)[Q4]])
        )
      TYPST
    end

    it "renders plain, highlighted, linked, and highlighted+linked quarters" do
      manifest = LYP::Planners::MOS::Manifest.new
      manifest.register_source(third_quarter.id)
      manifest.register_source(fourth_quarter.id)

      menu = described_class.new(i18n:, manifest:, range: first_quarter..fourth_quarter)
      menu.highlight([second_quarter, fourth_quarter])

      expect(menu.generate).to eq(expected)
    end
  end
end
