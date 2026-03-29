# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Pages::Monthly do
  let(:i18n) { class_double(I18n, "i18n") }
  let(:month) { make_month("2021-04") }
  let(:manifest) do
    m = LYP::Planners::MOS::Manifest.new
    m.register_source("2021-04-05")
    m.register_source("2021W14")
    m
  end

  before do
    translations = {
      "months.full.april" => "April",
      "weekday.full.monday" => "Monday",
      "weekday.full.tuesday" => "Tuesday",
      "weekday.full.wednesday" => "Wednesday",
      "weekday.full.thursday" => "Thursday",
      "weekday.full.friday" => "Friday",
      "weekday.full.saturday" => "Saturday",
      "weekday.full.sunday" => "Sunday",
      "monthly_notes" => "Notes",
      "week_name_full" => "Week"
    }

    allow(i18n).to receive(:t) { |key| translations.fetch(key) }
  end

  it "raises ConfigError for invalid week_placement" do
    expect do
      described_class.new(
        i18n:, manifest:, month:, title_size: "14pt",
        month_params: { week_placement: :invalid, week_label_width: "10mm",
                        heading_height: "2mm", daily_cell_height: "1fr", week_label_rotation: "-90deg" }
      )
    end.to raise_error(LYP::ConfigError, "week_placement: allowed: [:left, :right, :none]")
  end

  describe "#title" do
    let(:month_params) do
      { week_placement: :left, week_label_width: "10mm",
        heading_height: "2mm", daily_cell_height: "1fr", week_label_rotation: "-90deg" }
    end
    let(:page) { described_class.new(i18n:, manifest:, month:, title_size: "14pt", month_params:) }

    it "renders the month title" do
      expect(page.title).to eq("text(size: 14pt)[April<#{month.id}>]")
    end
  end

  describe "#content" do
    let(:page) { described_class.new(i18n:, manifest:, month:, title_size: "14pt", month_params:) }

    context "with week_placement: :left" do
      let(:month_params) do
        { week_placement: :left, week_label_width: "10mm",
          heading_height: "2mm", daily_cell_height: "1fr", week_label_rotation: "-90deg" }
      end

      let(:expected) do
        <<~TYPST.strip
          grid(
            columns: 1fr,
            rows: (auto, 1fr),

            grid(
              stroke: regular_stroke,
              columns: (10mm, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
              rows: (2mm, 1fr, 1fr, 1fr, 1fr, 1fr),

              [], align(center + horizon)[Monday], align(center + horizon)[Tuesday], align(center + horizon)[Wednesday], align(center + horizon)[Thursday], align(center + horizon)[Friday], align(center + horizon)[Saturday], align(center + horizon)[Sunday],
              align(center + horizon, rotate(-90deg, reflow: true)[#Week 13]), [], [], [], box(stroke: regular_stroke, inset: 3pt)[#1], box(stroke: regular_stroke, inset: 3pt)[#2], box(stroke: regular_stroke, inset: 3pt)[#3], box(stroke: regular_stroke, inset: 3pt)[#4],
          align(center + horizon, rotate(-90deg, reflow: true)[#padded_link(<2021W14>)[Week 14]]), box(stroke: regular_stroke, inset: 3pt)[#padded_link(<2021-04-05>)[5]], box(stroke: regular_stroke, inset: 3pt)[#6], box(stroke: regular_stroke, inset: 3pt)[#7], box(stroke: regular_stroke, inset: 3pt)[#8], box(stroke: regular_stroke, inset: 3pt)[#9], box(stroke: regular_stroke, inset: 3pt)[#10], box(stroke: regular_stroke, inset: 3pt)[#11],
          align(center + horizon, rotate(-90deg, reflow: true)[#Week 15]), box(stroke: regular_stroke, inset: 3pt)[#12], box(stroke: regular_stroke, inset: 3pt)[#13], box(stroke: regular_stroke, inset: 3pt)[#14], box(stroke: regular_stroke, inset: 3pt)[#15], box(stroke: regular_stroke, inset: 3pt)[#16], box(stroke: regular_stroke, inset: 3pt)[#17], box(stroke: regular_stroke, inset: 3pt)[#18],
          align(center + horizon, rotate(-90deg, reflow: true)[#Week 16]), box(stroke: regular_stroke, inset: 3pt)[#19], box(stroke: regular_stroke, inset: 3pt)[#20], box(stroke: regular_stroke, inset: 3pt)[#21], box(stroke: regular_stroke, inset: 3pt)[#22], box(stroke: regular_stroke, inset: 3pt)[#23], box(stroke: regular_stroke, inset: 3pt)[#24], box(stroke: regular_stroke, inset: 3pt)[#25],
          align(center + horizon, rotate(-90deg, reflow: true)[#Week 17]), box(stroke: regular_stroke, inset: 3pt)[#26], box(stroke: regular_stroke, inset: 3pt)[#27], box(stroke: regular_stroke, inset: 3pt)[#28], box(stroke: regular_stroke, inset: 3pt)[#29], box(stroke: regular_stroke, inset: 3pt)[#30], [], []
            ),

            grid(
              columns: (1fr),
              rows: (2mm, auto, 1fr),

              [],
              grid.cell(stroke: (bottom: thick_stroke), box(height: 5mm, align(horizon, [Notes]))),
              rect_pattern(dotted)
            )
          )
        TYPST
      end

      it "prepends the week column" do
        expect(page.content).to eq(expected)
      end
    end

    context "with week_placement: :right" do
      let(:month_params) do
        { week_placement: :right, week_label_width: "10mm",
          heading_height: "2mm", daily_cell_height: "1fr", week_label_rotation: "-90deg" }
      end

      let(:expected) do
        <<~TYPST.strip
          grid(
            columns: 1fr,
            rows: (auto, 1fr),

            grid(
              stroke: regular_stroke,
              columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 10mm),
              rows: (2mm, 1fr, 1fr, 1fr, 1fr, 1fr),

              align(center + horizon)[Monday], align(center + horizon)[Tuesday], align(center + horizon)[Wednesday], align(center + horizon)[Thursday], align(center + horizon)[Friday], align(center + horizon)[Saturday], align(center + horizon)[Sunday], [],
              [], [], [], box(stroke: regular_stroke, inset: 3pt)[#1], box(stroke: regular_stroke, inset: 3pt)[#2], box(stroke: regular_stroke, inset: 3pt)[#3], box(stroke: regular_stroke, inset: 3pt)[#4], align(center + horizon, rotate(-90deg, reflow: true)[#Week 13]),
          box(stroke: regular_stroke, inset: 3pt)[#padded_link(<2021-04-05>)[5]], box(stroke: regular_stroke, inset: 3pt)[#6], box(stroke: regular_stroke, inset: 3pt)[#7], box(stroke: regular_stroke, inset: 3pt)[#8], box(stroke: regular_stroke, inset: 3pt)[#9], box(stroke: regular_stroke, inset: 3pt)[#10], box(stroke: regular_stroke, inset: 3pt)[#11], align(center + horizon, rotate(-90deg, reflow: true)[#padded_link(<2021W14>)[Week 14]]),
          box(stroke: regular_stroke, inset: 3pt)[#12], box(stroke: regular_stroke, inset: 3pt)[#13], box(stroke: regular_stroke, inset: 3pt)[#14], box(stroke: regular_stroke, inset: 3pt)[#15], box(stroke: regular_stroke, inset: 3pt)[#16], box(stroke: regular_stroke, inset: 3pt)[#17], box(stroke: regular_stroke, inset: 3pt)[#18], align(center + horizon, rotate(-90deg, reflow: true)[#Week 15]),
          box(stroke: regular_stroke, inset: 3pt)[#19], box(stroke: regular_stroke, inset: 3pt)[#20], box(stroke: regular_stroke, inset: 3pt)[#21], box(stroke: regular_stroke, inset: 3pt)[#22], box(stroke: regular_stroke, inset: 3pt)[#23], box(stroke: regular_stroke, inset: 3pt)[#24], box(stroke: regular_stroke, inset: 3pt)[#25], align(center + horizon, rotate(-90deg, reflow: true)[#Week 16]),
          box(stroke: regular_stroke, inset: 3pt)[#26], box(stroke: regular_stroke, inset: 3pt)[#27], box(stroke: regular_stroke, inset: 3pt)[#28], box(stroke: regular_stroke, inset: 3pt)[#29], box(stroke: regular_stroke, inset: 3pt)[#30], [], [], align(center + horizon, rotate(-90deg, reflow: true)[#Week 17])
            ),

            grid(
              columns: (1fr),
              rows: (2mm, auto, 1fr),

              [],
              grid.cell(stroke: (bottom: thick_stroke), box(height: 5mm, align(horizon, [Notes]))),
              rect_pattern(dotted)
            )
          )
        TYPST
      end

      it "appends the week column" do
        expect(page.content).to eq(expected)
      end
    end

    context "with week_placement: :none" do
      let(:month_params) do
        { week_placement: :none, week_label_width: "10mm",
          heading_height: "2mm", daily_cell_height: "1fr", week_label_rotation: "-90deg" }
      end

      let(:expected) do
        <<~TYPST.strip
          grid(
            columns: 1fr,
            rows: (auto, 1fr),

            grid(
              stroke: regular_stroke,
              columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
              rows: (2mm, 1fr, 1fr, 1fr, 1fr, 1fr),

              align(center + horizon)[Monday], align(center + horizon)[Tuesday], align(center + horizon)[Wednesday], align(center + horizon)[Thursday], align(center + horizon)[Friday], align(center + horizon)[Saturday], align(center + horizon)[Sunday],
              [], [], [], box(stroke: regular_stroke, inset: 3pt)[#1], box(stroke: regular_stroke, inset: 3pt)[#2], box(stroke: regular_stroke, inset: 3pt)[#3], box(stroke: regular_stroke, inset: 3pt)[#4],
          box(stroke: regular_stroke, inset: 3pt)[#padded_link(<2021-04-05>)[5]], box(stroke: regular_stroke, inset: 3pt)[#6], box(stroke: regular_stroke, inset: 3pt)[#7], box(stroke: regular_stroke, inset: 3pt)[#8], box(stroke: regular_stroke, inset: 3pt)[#9], box(stroke: regular_stroke, inset: 3pt)[#10], box(stroke: regular_stroke, inset: 3pt)[#11],
          box(stroke: regular_stroke, inset: 3pt)[#12], box(stroke: regular_stroke, inset: 3pt)[#13], box(stroke: regular_stroke, inset: 3pt)[#14], box(stroke: regular_stroke, inset: 3pt)[#15], box(stroke: regular_stroke, inset: 3pt)[#16], box(stroke: regular_stroke, inset: 3pt)[#17], box(stroke: regular_stroke, inset: 3pt)[#18],
          box(stroke: regular_stroke, inset: 3pt)[#19], box(stroke: regular_stroke, inset: 3pt)[#20], box(stroke: regular_stroke, inset: 3pt)[#21], box(stroke: regular_stroke, inset: 3pt)[#22], box(stroke: regular_stroke, inset: 3pt)[#23], box(stroke: regular_stroke, inset: 3pt)[#24], box(stroke: regular_stroke, inset: 3pt)[#25],
          box(stroke: regular_stroke, inset: 3pt)[#26], box(stroke: regular_stroke, inset: 3pt)[#27], box(stroke: regular_stroke, inset: 3pt)[#28], box(stroke: regular_stroke, inset: 3pt)[#29], box(stroke: regular_stroke, inset: 3pt)[#30], [], []
            ),

            grid(
              columns: (1fr),
              rows: (2mm, auto, 1fr),

              [],
              grid.cell(stroke: (bottom: thick_stroke), box(height: 5mm, align(horizon, [Notes]))),
              rect_pattern(dotted)
            )
          )
        TYPST
      end

      it "omits the week column" do
        expect(page.content).to eq(expected)
      end
    end
  end
end
