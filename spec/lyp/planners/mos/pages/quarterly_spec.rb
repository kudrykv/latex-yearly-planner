# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Pages::Quarterly do
  let(:i18n) { class_double(I18n, "i18n") }
  let(:quarter) { make_quarter("2021-01-01") }
  let(:manifest) { LYP::Planners::MOS::Manifest.new }
  let(:little_calendar) { { week_placement: :none } }

  before do
    translations = {
      "quarters.long" => "Quarter",
      "weekday.one_letter.monday" => "M",
      "weekday.one_letter.tuesday" => "T",
      "weekday.one_letter.wednesday" => "W",
      "weekday.one_letter.thursday" => "T",
      "weekday.one_letter.friday" => "F",
      "weekday.one_letter.saturday" => "S",
      "weekday.one_letter.sunday" => "S",
      "weekday.one_letter.week" => "W"
    }

    allow(i18n).to receive(:t) { |key| translations.fetch(key) }
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

            grid(
            align: center + horizon,
            inset: 5pt,
            stroke: none,
            columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),

            [M], [T], [W], [T], [F], [S], [S],
            [], [], [], [], 1, 2, 3,
          4, 5, 6, 7, 8, 9, 10,
          11, 12, 13, 14, 15, 16, 17,
          18, 19, 20, 21, 22, 23, 24,
          25, 26, 27, 28, 29, 30, 31
          ), grid(
            align: center + horizon,
            inset: 5pt,
            stroke: none,
            columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),

            [M], [T], [W], [T], [F], [S], [S],
            1, 2, 3, 4, 5, 6, 7,
          8, 9, 10, 11, 12, 13, 14,
          15, 16, 17, 18, 19, 20, 21,
          22, 23, 24, 25, 26, 27, 28
          ), grid(
            align: center + horizon,
            inset: 5pt,
            stroke: none,
            columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),

            [M], [T], [W], [T], [F], [S], [S],
            1, 2, 3, 4, 5, 6, 7,
          8, 9, 10, 11, 12, 13, 14,
          15, 16, 17, 18, 19, 20, 21,
          22, 23, 24, 25, 26, 27, 28,
          29, 30, 31, [], [], [], []
          )
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

            grid(
            align: center + horizon,
            inset: 5pt,
            stroke: none,
            columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),

            [M], [T], [W], [T], [F], [S], [S],
            [], [], [], [], 1, 2, 3,
          4, 5, 6, 7, 8, 9, 10,
          11, 12, 13, 14, 15, 16, 17,
          18, 19, 20, 21, 22, 23, 24,
          25, 26, 27, 28, 29, 30, 31
          ), grid(
            align: center + horizon,
            inset: 5pt,
            stroke: none,
            columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),

            [M], [T], [W], [T], [F], [S], [S],
            1, 2, 3, 4, 5, 6, 7,
          8, 9, 10, 11, 12, 13, 14,
          15, 16, 17, 18, 19, 20, 21,
          22, 23, 24, 25, 26, 27, 28
          ), grid(
            align: center + horizon,
            inset: 5pt,
            stroke: none,
            columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),

            [M], [T], [W], [T], [F], [S], [S],
            1, 2, 3, 4, 5, 6, 7,
          8, 9, 10, 11, 12, 13, 14,
          15, 16, 17, 18, 19, 20, 21,
          22, 23, 24, 25, 26, 27, 28,
          29, 30, 31, [], [], [], []
          )
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
