# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Pages::Quarterly do
  let(:i18n) { class_double(I18n, "i18n") }
  let(:quarter) { make_quarter("2021-01-01") }
  let(:manifest) { LYP::Planners::MOS::Manifest.new }
  let(:little_calendar) { { week_placement: :none } }

  before do
    allow(i18n).to receive(:t).with("quarters.long").and_return("Quarter")

    calendar = instance_double(LYP::Planners::MOS::Components::LittleCalendar, generate: "[calendar]")
    allow(LYP::Planners::MOS::Components::LittleCalendar).to receive(:new).and_return(calendar)
  end

  describe "#title" do
    let(:page) do
      described_class.new(
        i18n:, manifest:, quarter:,
        months_column: :left, little_calendar:
      )
    end

    it "renders the quarter title" do
      expect(page.title).to eq("[Quarter 1 <#{quarter.id}>]")
    end
  end

  describe "#content" do
    context "with months_column: :left" do
      let(:page) do
        described_class.new(
          i18n:, manifest:, quarter:,
          months_column: :left, little_calendar:
        )
      end

      let(:expected) do
        <<~TYPST.strip
          grid(
            columns: (2fr,3fr),

            stack(
            dir: ttb,
            spacing: 1fr,

            [calendar], [calendar], [calendar]
          ), rect_pattern(dotted)
          )
        TYPST
      end

      it "renders calendars on the left and dotted pattern on the right" do
        expect(page.content).to eq(expected)
      end
    end

    context "with months_column: :right" do
      let(:page) do
        described_class.new(
          i18n:, manifest:, quarter:,
          months_column: :right, little_calendar:
        )
      end

      let(:expected) do
        <<~TYPST.strip
          grid(
            columns: (3fr,2fr),

            rect_pattern(dotted), stack(
            dir: ttb,
            spacing: 1fr,

            [calendar], [calendar], [calendar]
          )
          )
        TYPST
      end

      it "renders dotted pattern on the left and calendars on the right" do
        expect(page.content).to eq(expected)
      end
    end
  end
end
