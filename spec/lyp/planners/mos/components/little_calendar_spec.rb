# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Components::LittleCalendar do
  let(:i18n) { class_double(I18n, "i18n") }

  before do
    translations = {
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

  describe "#generate" do
    context "with week_placement: :left" do
      let(:component) do
        described_class.new(i18n:, manifest:, week_placement: :left, month:)
      end

      context "with a month starting on Monday (no nil padding)" do
        let(:month) { make_month("2021-02") }
        let(:manifest) { LYP::Planners::MOS::Manifest.new }

        let(:expected) do
          <<~TYPST.strip
            grid(
              align: center + horizon,
              inset: 5pt,
              stroke: (x, _) => if x == 1 {( left: 0.4pt )},
              columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),

              [W], [M], [T], [W], [T], [F], [S], [S],
              5, 1, 2, 3, 4, 5, 6, 7,
            6, 8, 9, 10, 11, 12, 13, 14,
            7, 15, 16, 17, 18, 19, 20, 21,
            8, 22, 23, 24, 25, 26, 27, 28
            )
          TYPST
        end

        it "returns a grid with week column prepended and stroke on column 1" do
          expect(component.generate).to eq(expected)
        end
      end

      context "with a month not starting on Monday (nil-padded weeks)" do
        let(:month) { make_month("2026-01") }
        let(:manifest) { LYP::Planners::MOS::Manifest.new }

        let(:expected) do
          <<~TYPST.strip
            grid(
              align: center + horizon,
              inset: 5pt,
              stroke: (x, _) => if x == 1 {( left: 0.4pt )},
              columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),

              [W], [M], [T], [W], [T], [F], [S], [S],
              1, [], [], [], 1, 2, 3, 4,
            2, 5, 6, 7, 8, 9, 10, 11,
            3, 12, 13, 14, 15, 16, 17, 18,
            4, 19, 20, 21, 22, 23, 24, 25,
            5, 26, 27, 28, 29, 30, 31, []
            )
          TYPST
        end

        it "returns [] for outside-month days" do
          expect(component.generate).to eq(expected)
        end
      end

      context "with manifest sources registered" do
        let(:month) { make_month("2021-02") }

        let(:manifest) do
          m = LYP::Planners::MOS::Manifest.new
          m.register_source("2021-02-01")
          m.register_source("2021W05")
          m
        end

        let(:expected) do
          <<~TYPST.strip
            grid(
              align: center + horizon,
              inset: 5pt,
              stroke: (x, _) => if x == 1 {( left: 0.4pt )},
              columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),

              [W], [M], [T], [W], [T], [F], [S], [S],
              padded_link(<2021W05>)[5], padded_link(<2021-02-01>, padding: 6pt)[1], 2, 3, 4, 5, 6, 7,
            6, 8, 9, 10, 11, 12, 13, 14,
            7, 15, 16, 17, 18, 19, 20, 21,
            8, 22, 23, 24, 25, 26, 27, 28
            )
          TYPST
        end

        it "wraps linked days and weeks in padded_link" do
          expect(component.generate).to eq(expected)
        end
      end
    end

    context "with week_placement: :right" do
      let(:month) { make_month("2021-02") }
      let(:manifest) { LYP::Planners::MOS::Manifest.new }

      let(:component) do
        described_class.new(i18n:, manifest:, week_placement: :right, month:)
      end

      let(:expected) do
        <<~TYPST.strip
          grid(
            align: center + horizon,
            inset: 5pt,
            stroke: (x, _) => if x == 7 {( left: 0.4pt )},
            columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),

            [M], [T], [W], [T], [F], [S], [S], [W],
            1, 2, 3, 4, 5, 6, 7, 5,
          8, 9, 10, 11, 12, 13, 14, 6,
          15, 16, 17, 18, 19, 20, 21, 7,
          22, 23, 24, 25, 26, 27, 28, 8
          )
        TYPST
      end

      it "returns a grid with week column appended and stroke on column 7" do
        expect(component.generate).to eq(expected)
      end
    end

    context "with week_placement: :none" do
      let(:month) { make_month("2021-02") }
      let(:manifest) { LYP::Planners::MOS::Manifest.new }

      let(:component) do
        described_class.new(i18n:, manifest:, week_placement: :none, month:)
      end

      let(:expected) do
        <<~TYPST.strip
          grid(
            align: center + horizon,
            inset: 5pt,
            stroke: none,
            columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),

            [M], [T], [W], [T], [F], [S], [S],
            1, 2, 3, 4, 5, 6, 7,
          8, 9, 10, 11, 12, 13, 14,
          15, 16, 17, 18, 19, 20, 21,
          22, 23, 24, 25, 26, 27, 28
          )
        TYPST
      end

      it "returns a grid without week column and with stroke: none" do
        expect(component.generate).to eq(expected)
      end
    end

    it "accepts and ignores extra keyword arguments" do
      expect do
        described_class.new(
          i18n:, manifest: LYP::Planners::MOS::Manifest.new,
          week_placement: :left, month: make_month("2021-02"),
          day: make_day("2021-02-15"), extra_param: "ignored"
        )
      end.not_to raise_error
    end
  end
end
