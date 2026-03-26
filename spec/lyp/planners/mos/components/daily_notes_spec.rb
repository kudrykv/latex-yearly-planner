# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Components::DailyNotes do
  let(:i18n) { class_double(I18n, "i18n") }

  before do
    allow(i18n).to receive(:t).with("daily_notes").and_return("Notes")
  end

  describe "#generate" do
    let(:component) do
      described_class.new(
        i18n:,
        title_height: "5mm",
        notes_height: "1fr",
        pattern: "dotted"
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

    it "accepts and ignores extra keyword arguments" do
      expect do
        described_class.new(i18n: i18n, title_height: "5mm", notes_height: "1fr",
                            pattern: "dotted", manifest: nil, month: nil, day: nil)
      end.not_to raise_error
    end
  end
end
