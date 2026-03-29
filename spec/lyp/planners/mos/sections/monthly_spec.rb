# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Sections::Monthly do
  describe "#section_name" do
    let(:configurator) { instance_double(LYP::Planners::MOS::Configurator) }
    let(:i18n) { class_double(I18n, "i18n") }

    let(:section) do
      described_class.new(
        section_name: "monthly", i18n:, configurator:,
        title_size: "14pt", month_params: { week_placement: :left }
      )
    end

    it "returns the name" do
      expect(section.section_name).to eq("monthly")
    end
  end

  describe "#register" do
    let(:i18n) { class_double(I18n, "i18n") }
    let(:manifest) { LYP::Planners::MOS::Manifest.new }

    let(:configurator) do
      instance_double(
        LYP::Planners::MOS::Configurator,
        start_date: make_day("2025-01-01"),
        end_date: make_day("2025-03-31")
      )
    end

    let(:section) do
      described_class.new(
        section_name: "monthly", i18n:, configurator:,
        title_size: "14pt", month_params: { week_placement: :left }
      )
    end

    it "registers each month's ID with the manifest" do
      section.register(manifest)

      expect(manifest.source?(make_month("2025-01").id)).to be true
      expect(manifest.source?(make_month("2025-02").id)).to be true
      expect(manifest.source?(make_month("2025-03").id)).to be true
    end
  end

  describe "#pages" do
    let(:i18n) { class_double(I18n, "i18n") }
    let(:manifest) { LYP::Planners::MOS::Manifest.new }
    let(:month_params) { { week_placement: :left } }
    let(:month_dates) { %w[2025-01 2025-02 2025-03] }

    let(:configurator) do
      instance_double(
        LYP::Planners::MOS::Configurator,
        start_date: make_day("2025-01-01"),
        end_date: make_day("2025-03-31")
      )
    end

    let(:section) do
      described_class.new(section_name: "monthly", i18n:, configurator:, title_size: "14pt", month_params:)
    end

    let(:expected) do
      month_dates.each_with_index.map do |date, i|
        month = make_month(date)
        LYP::Planners::MOS::PageData.new(
          title: "title-m#{i + 1}",
          content: "content-m#{i + 1}",
          highlight_months: [month],
          highlight_quarters: [month.quarter]
        )
      end
    end

    before do
      month_dates.each_with_index do |date, i|
        month = make_month(date)
        page_double = instance_double(
          LYP::Planners::MOS::Pages::Monthly,
          title: "title-m#{i + 1}",
          content: "content-m#{i + 1}"
        )
        allow(LYP::Planners::MOS::Pages::Monthly).to receive(:new).with(
          i18n:, manifest:, month:, title_size: "14pt", month_params:
        ).and_return(page_double)
      end
    end

    it "returns one PageData per month with correct fields" do
      expect(section.pages(manifest)).to eq(expected)
    end
  end

  describe "constructor" do
    let(:i18n) { class_double(I18n, "i18n") }
    let(:configurator) { instance_double(LYP::Planners::MOS::Configurator) }

    it "accepts and ignores extra keyword arguments" do
      expect do
        described_class.new(
          section_name: "monthly", i18n:, configurator:,
          title_size: "14pt", month_params: { week_placement: :left },
          manifest: LYP::Planners::MOS::Manifest.new, extra_key: "ignored"
        )
      end.not_to raise_error
    end
  end
end
