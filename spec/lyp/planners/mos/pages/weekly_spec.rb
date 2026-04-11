# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Pages::Weekly do
  let(:i18n) { class_double(I18n, "i18n") }
  let(:week) { make_week("2021-02-15") }

  let(:manifest) do
    m = LYP::Planners::MOS::Manifest.new
    m.register_source("2021-02-15")
    m.register_source("2021-02-18")
    m
  end

  let(:column_gutter) { "5pt" }

  before do
    translations = {
      "week_name_full" => "Week",
      "notes" => "Notes"
    }

    allow(i18n).to receive(:t) { |key| translations.fetch(key) }
  end

  describe "#title" do
    let(:page) { described_class.new(i18n:, manifest:, week:, column_gutter:) }

    it "renders the week number and label" do
      expect(page.title).to eq("text(size: h1)[Week #{week.number} <#{week.id}>]")
    end
  end

  describe "#content" do
    let(:page) { described_class.new(i18n:, manifest:, week:, column_gutter:) }

    let(:expected) do
      <<~TYPST.strip
        grid(
          columns: (1fr, 1fr, 1fr),
          rows: (4mm, 1fr, 4mm, 1fr, 4mm, 1fr),
          column-gutter: #{column_gutter},

          grid.cell(stroke: (bottom: thick_stroke), padded_link(<2021-02-15>, [Monday, 15])), grid.cell(stroke: (bottom: thick_stroke), [Tuesday, 16]), grid.cell(stroke: (bottom: thick_stroke), [Wednesday, 17]),
          grid.cell(colspan: 3, scratch_pad),
          grid.cell(stroke: (bottom: thick_stroke), padded_link(<2021-02-18>, [Thursday, 18])), grid.cell(stroke: (bottom: thick_stroke), [Friday, 19]), grid.cell(stroke: (bottom: thick_stroke), [Saturday, 20]),
          grid.cell(colspan: 3, scratch_pad),
          grid.cell(stroke: (bottom: thick_stroke), [Sunday, 21]), grid.cell(colspan: 2, stroke: (bottom: thick_stroke), [Notes]),
          grid.cell(colspan: 3, scratch_pad)
        )
      TYPST
    end

    it "renders the weekly grid with linked and plain days" do
      expect(page.content).to eq(expected)
    end
  end
end
