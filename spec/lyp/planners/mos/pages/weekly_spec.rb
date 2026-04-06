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
      expect(page.title).to eq("[Week #{week.number} <#{week.id}>]")
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

          padded_link(<2021-02-15>, box(
          stroke: (bottom: thick_stroke),
          width: 100%,
          inset: (bottom: 4pt),
          outset: 0pt
        )[Monday, 15]), box(
          stroke: (bottom: thick_stroke),
          width: 100%,
          inset: (bottom: 4pt),
          outset: 0pt
        )[Tuesday, 16], box(
          stroke: (bottom: thick_stroke),
          width: 100%,
          inset: (bottom: 4pt),
          outset: 0pt
        )[Wednesday, 17],
          grid.cell(colspan: 3, scratch_pad),
          padded_link(<2021-02-18>, box(
          stroke: (bottom: thick_stroke),
          width: 100%,
          inset: (bottom: 4pt),
          outset: 0pt
        )[Thursday, 18]), box(
          stroke: (bottom: thick_stroke),
          width: 100%,
          inset: (bottom: 4pt),
          outset: 0pt
        )[Friday, 19], box(
          stroke: (bottom: thick_stroke),
          width: 100%,
          inset: (bottom: 4pt),
          outset: 0pt
        )[Saturday, 20],
          grid.cell(colspan: 3, scratch_pad),
          box(
          stroke: (bottom: thick_stroke),
          width: 100%,
          inset: (bottom: 4pt),
          outset: 0pt
        )[Sunday, 21], grid.cell(colspan: 2, stroke: (bottom: thick_stroke), [Notes]),
          grid.cell(colspan: 3, scratch_pad)
        )
      TYPST
    end

    it "renders the weekly grid with linked and plain days" do
      expect(page.content).to eq(expected)
    end
  end
end
