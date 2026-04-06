# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Sections::Weekly do
  describe "#section_name" do
    let(:i18n) { class_double(I18n, "i18n") }
    let(:configurator) { make_configurator(start_date: "2021-02-01", end_date: "2021-02-28") }

    let(:column_gutter) { "5pt" }

    let(:section) { described_class.new(section_name: "weekly", i18n:, configurator:, column_gutter:) }

    it "returns the name" do
      expect(section.section_name).to eq("weekly")
    end
  end

  describe "#register" do
    let(:i18n) { class_double(I18n, "i18n") }
    let(:manifest) { LYP::Planners::MOS::Manifest.new }
    let(:column_gutter) { "5pt" }

    let(:configurator) { make_configurator(start_date: "2021-02-01", end_date: "2021-02-28") }

    let(:section) { described_class.new(section_name: "weekly", i18n:, configurator:, column_gutter:) }

    it "registers each week's ID with the manifest" do
      section.register(manifest)

      expect(manifest.source?("2021W05")).to be true
      expect(manifest.source?("2021W06")).to be true
      expect(manifest.source?("2021W07")).to be true
      expect(manifest.source?("2021W08")).to be true
    end
  end

  describe "#pages" do
    let(:i18n) { class_double(I18n, "i18n") }
    let(:manifest) { LYP::Planners::MOS::Manifest.new }
    let(:column_gutter) { "5pt" }
    let(:week_ids) { %w[2021W05 2021W06 2021W07 2021W08] }
    let(:feb) { make_month("2021-02") }
    let(:q1) { make_quarter("2021-01-01") }

    let(:configurator) { make_configurator(start_date: "2021-02-01", end_date: "2021-02-28") }

    let(:section) { described_class.new(section_name: "weekly", i18n:, configurator:, column_gutter:) }

    let(:expected) do
      week_ids.map do |id|
        LYP::Planners::MOS::PageData.new(
          title: "title-#{id}",
          content: "content-#{id}",
          highlight_months: [feb],
          highlight_quarters: [q1]
        )
      end
    end

    before do
      allow(LYP::Planners::MOS::Pages::Weekly).to receive(:new) do |**kwargs|
        week = kwargs[:week]
        instance_double(
          LYP::Planners::MOS::Pages::Weekly,
          title: "title-#{week.id}",
          content: "content-#{week.id}"
        )
      end
    end

    it "returns one PageData per week with correct fields" do
      expect(section.pages(manifest)).to eq(expected)
    end
  end

  describe "constructor" do
    let(:i18n) { class_double(I18n, "i18n") }
    let(:configurator) { make_configurator(start_date: "2021-02-01", end_date: "2021-02-28") }

    let(:column_gutter) { "5pt" }

    it "accepts and ignores extra keyword arguments" do
      expect do
        described_class.new(
          section_name: "weekly", i18n:, configurator:, column_gutter:,
          manifest: LYP::Planners::MOS::Manifest.new, extra_param: "ignored"
        )
      end.not_to raise_error
    end
  end
end
