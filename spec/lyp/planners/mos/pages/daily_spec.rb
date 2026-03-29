# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Pages::Daily do
  let(:i18n) { class_double(I18n, "i18n") }
  let(:day) { make_day("2021-02-15") }
  let(:week) { day.week }
  let(:manifest) { LYP::Planners::MOS::Manifest.new }

  before do
    translations = {
      "week_name_full" => "Week",
      "weekday.full.monday" => "Monday"
    }

    allow(i18n).to receive(:t) { |key| translations.fetch(key) }
  end

  describe "#title" do
    let(:page) do
      described_class.new(
        i18n:, manifest:, day:,
        columns_width: "(3fr, 2fr)",
        column_gutter: "4mm",
        items_spacing: "2mm",
        left_column: [], right_column: [],
        debug:
      )
    end
    let(:debug) { false }

    context "when manifest is empty" do
      let(:expected) do
        <<~TYPST.strip
          grid(
            columns: (auto, auto),
            rows: (3fr, 2fr),
            column-gutter: 4pt,
          #{" " * 2}

            grid.cell(
              rowspan: 2,
              align: center + horizon,
              rect(
                stroke: (right: regular_stroke),

                text(size: 24pt)[15 <#{day.id}>]
              )
            ),
            [*Monday*],
            Week 7
          )
        TYPST
      end

      it "renders the day number, weekday name, and week reference" do
        expect(page.title).to eq(expected)
      end
    end

    context "when the week has a manifest source" do
      let(:manifest) do
        m = LYP::Planners::MOS::Manifest.new
        m.register_source("2021W07")
        m
      end
      let(:expected) do
        <<~TYPST.strip
          grid(
            columns: (auto, auto),
            rows: (3fr, 2fr),
            column-gutter: 4pt,
          #{" " * 2}

            grid.cell(
              rowspan: 2,
              align: center + horizon,
              rect(
                stroke: (right: regular_stroke),

                text(size: 24pt)[15 <#{day.id}>]
              )
            ),
            [*Monday*],
            link(<#{week.id}>)[Week 7]
          )
        TYPST
      end

      it "wraps the week reference in a link" do
        expect(page.title).to eq(expected)
      end
    end

    context "when debug is enabled" do
      let(:debug) { true }
      let(:expected) do
        <<~TYPST.strip
          grid(
            columns: (auto, auto),
            rows: (3fr, 2fr),
            column-gutter: 4pt,
            stroke: regular_stroke,

            grid.cell(
              rowspan: 2,
              align: center + horizon,
              rect(
                stroke: (right: regular_stroke),

                text(size: 24pt)[15 <#{day.id}>]
              )
            ),
            [*Monday*],
            Week 7
          )
        TYPST
      end

      it "adds stroke to the grid" do
        expect(page.title).to eq(expected)
      end
    end
  end

  describe "#content" do
    context "with enabled components" do
      before do
        priorities = instance_double(LYP::Planners::MOS::Components::DailyTopPriorities, generate: "[TOP_PRIORITIES]")
        allow(LYP::Planners::MOS::Components::DailyTopPriorities).to receive(:new).with(
          i18n:, manifest:, month: day.month, day:, number: 1
        ).and_return(priorities)

        notes = instance_double(LYP::Planners::MOS::Components::DailyNotes, generate: "[NOTES]")
        allow(LYP::Planners::MOS::Components::DailyNotes).to receive(:new).with(
          i18n:, manifest:, month: day.month, day:,
          title_height: "5mm", notes_height: "1fr", pattern: "dotted"
        ).and_return(notes)
      end

      let(:page) do
        described_class.new(
          i18n:, manifest:, day:,
          columns_width: "(3fr, 2fr)",
          column_gutter: "4mm",
          items_spacing: "2mm",
          left_column: [
            { enabled: true, class: "top_priorities", params: { number: 1 } },
            { enabled: true, class: "notes", params: { title_height: "5mm", notes_height: "1fr", pattern: "dotted" } }
          ],
          right_column: [
            { enabled: true, class: "top_priorities", params: { number: 1 } }
          ]
        )
      end

      let(:expected) do
        <<~TYPST.strip
          grid(
            columns: (3fr, 2fr),
            rows: 1fr,
            column-gutter: 4mm,
            stack(
            dir: ttb,
            spacing: 2mm,
            [TOP_PRIORITIES],
          [NOTES]
          ),
            stack(
            dir: ttb,
            spacing: 2mm,
            [TOP_PRIORITIES]
          )
          )
        TYPST
      end

      it "renders components into column stacks" do
        expect(page.content).to eq(expected)
      end
    end

    context "when a component is disabled" do
      before do
        priorities = instance_double(LYP::Planners::MOS::Components::DailyTopPriorities, generate: "[TOP_PRIORITIES]")
        allow(LYP::Planners::MOS::Components::DailyTopPriorities).to receive(:new).with(
          i18n:, manifest:, month: day.month, day:, number: 1
        ).and_return(priorities)
      end

      let(:page) do
        described_class.new(
          i18n:, manifest:, day:,
          columns_width: "(3fr, 2fr)",
          column_gutter: "4mm",
          items_spacing: "2mm",
          left_column: [
            { enabled: true, class: "top_priorities", params: { number: 1 } },
            { enabled: false, class: "notes", params: { title_height: "5mm", notes_height: "1fr", pattern: "dotted" } }
          ],
          right_column: [
            { enabled: true, class: "top_priorities", params: { number: 1 } }
          ]
        )
      end

      it "excludes the disabled component from the output" do
        expect(page.content).not_to include("[NOTES]")
        expect(page.content).to include("[TOP_PRIORITIES]")
      end
    end

    context "when an unknown component class is referenced" do
      let(:page) do
        described_class.new(
          i18n:, manifest:, day:,
          columns_width: "(3fr, 2fr)",
          column_gutter: "4mm",
          items_spacing: "2mm",
          left_column: [
            { enabled: true, class: "nonexistent", params: {} }
          ],
          right_column: []
        )
      end

      it "raises ConfigError" do
        expect { page.content }.to raise_error(LYP::ConfigError, "unknown component: nonexistent")
      end
    end

    context "when an unknown component class is disabled" do
      let(:page) do
        described_class.new(
          i18n:, manifest:, day:,
          columns_width: "(3fr, 2fr)",
          column_gutter: "4mm",
          items_spacing: "2mm",
          left_column: [
            { enabled: false, class: "nonexistent", params: {} }
          ],
          right_column: []
        )
      end

      it "does not raise" do
        expect { page.content }.not_to raise_error
      end
    end
  end
end
