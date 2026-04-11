# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Components::DailyTopPriorities do
  let(:i18n) { class_double(I18n, "i18n") }

  before do
    allow(i18n).to receive(:t).with("top_priorities").and_return("Top priorities")
  end

  describe "#generate" do
    let(:component) { described_class.new(i18n:, number: 3) }

    let(:expected) do
      <<~TYPST.strip
        grid(
          columns: 1fr,
          inset: 0mm,
          stroke: (_, _) => (bottom: regular_stroke),

          grid.cell(stroke: (bottom: thick_stroke), box(height: regular_height, align(horizon, [Top priorities]))),
          box(height: regular_height, align(horizon, [$square.stroked$])),
        box(height: regular_height, align(horizon, [$square.stroked$])),
        box(height: regular_height, align(horizon, [$square.stroked$]))
        )
      TYPST
    end

    it "returns a grid with the translated title and 3 checkbox rows" do
      expect(component.generate).to eq(expected)
    end

    it "accepts and ignores extra keyword arguments" do
      expect do
        described_class.new(i18n:, number: 3, manifest: nil, month: nil, day: nil)
      end.not_to raise_error
    end
  end
end
