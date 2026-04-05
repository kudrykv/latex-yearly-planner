# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Components::DailyNotes do
  let(:i18n) { class_double(I18n, "i18n") }

  before do
    allow(i18n).to receive(:t).with("daily_notes").and_return("Notes")
    allow(i18n).to receive(:t).with("more_daily_notes").and_return("More")
  end

  describe "#generate" do
    let(:day) { make_day("2026-04-05") }
    let(:manifest) { LYP::Planners::MOS::Manifest.new }

    let(:component) do
      described_class.new(
        i18n:, manifest:, day:,
        title_height: "5mm", notes_height: "1fr", pattern: "dotted"
      )
    end

    it "returns a grid with the configured rows, translated title, and pattern" do
      expect(component.generate).to eq(<<~TYPST.strip)
        grid(
          columns: 1fr,
          rows: (5mm, 1fr),
          grid.cell(align:horizon, stroke: (bottom: 1pt), [Notes]),
          rect_pattern(dotted)
        )
      TYPST
    end

    context "when the manifest has the daily note source registered" do
      before { manifest.register_source("daily-note-2026-04-05-page-1") }

      it "appends a padded_link to the title" do
        expect(component.generate).to eq(<<~TYPST.strip)
          grid(
            columns: 1fr,
            rows: (5mm, 1fr),
            grid.cell(align:horizon, stroke: (bottom: 1pt), [Notes #padded_link(<daily-note-2026-04-05-page-1>)[| More]]),
            rect_pattern(dotted)
          )
        TYPST
      end
    end

    it "accepts and ignores extra keyword arguments" do
      expect do
        described_class.new(
          i18n:, manifest:, day:,
          title_height: "5mm", notes_height: "1fr", pattern: "dotted",
          month: nil
        )
      end.not_to raise_error
    end
  end
end
