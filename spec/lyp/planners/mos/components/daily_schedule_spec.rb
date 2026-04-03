# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Components::DailySchedule do
  let(:i18n) { class_double(I18n, "i18n") }

  before do
    allow(i18n).to receive(:t).with("schedule").and_return("Schedule")
  end

  describe "#generate" do
    context "when trailing_30_minutes is true" do
      let(:component) do
        described_class.new(i18n:, from: 8, to: 9, trailing_30_minutes: true, time_format: "%k")
      end

      let(:expected) do
        <<~TYPST.strip
          grid(
            columns: 1fr,
            inset: 0mm,
            stroke: (_, y) =>
              if calc.even(y) { ( bottom: regular_stroke + black ) }
              else { ( bottom: regular_stroke + gray ) },
            grid.cell(stroke: (bottom: 1pt), box(height: regular_height, align(horizon, [Schedule]))),
            box(height: regular_height, align(horizon, [ 8])), box(height: regular_height),
          box(height: regular_height, align(horizon, [ 9])), box(height: regular_height),

            box(height: regular_height)
          )
        TYPST
      end

      it "returns a grid with schedule lines and trailing box" do
        expect(component.generate).to eq(expected)
      end
    end

    context "when trailing_30_minutes is false" do
      let(:component) do
        described_class.new(i18n:, from: 8, to: 9, trailing_30_minutes: false, time_format: "%k")
      end

      let(:expected) do
        <<~TYPST.strip
          grid(
            columns: 1fr,
            inset: 0mm,
            stroke: (_, y) =>
              if calc.even(y) { ( bottom: regular_stroke + black ) }
              else { ( bottom: regular_stroke + gray ) },
            grid.cell(stroke: (bottom: 1pt), box(height: regular_height, align(horizon, [Schedule]))),
            box(height: regular_height, align(horizon, [ 8])), box(height: regular_height),
          box(height: regular_height, align(horizon, [ 9])), box(height: regular_height),

          #{" " * 2}
          )
        TYPST
      end

      it "returns a grid with schedule lines and no trailing box" do
        expect(component.generate).to eq(expected)
      end
    end

    it "accepts and ignores extra keyword arguments" do
      expect do
        described_class.new(
          i18n:, from: 8, to: 9, trailing_30_minutes: true, time_format: "%k",
          manifest: nil, month: nil, day: nil
        )
      end.not_to raise_error
    end
  end
end
