# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Sections::Quarterly do
  describe "#registered_section_name" do
    let(:configurator) { instance_double(LYP::Planners::MOS::Configurator) }
    let(:i18n) { class_double(I18n, "i18n") }

    let(:section) do
      described_class.new(
        name: "quarterly", i18n:, configurator:,
        months_column: "left", little_calendar: { week_placement: :none }
      )
    end

    it "returns the name" do
      expect(section.registered_section_name).to eq("quarterly")
    end
  end

  describe "#register" do
    let(:i18n) { class_double(I18n, "i18n") }
    let(:manifest) { LYP::Planners::MOS::Manifest.new }

    let(:configurator) do
      instance_double(
        LYP::Planners::MOS::Configurator,
        start_date: make_day("2025-01-01"),
        end_date: make_day("2025-12-31")
      )
    end

    let(:section) do
      described_class.new(
        name: "quarterly", i18n:, configurator:,
        months_column: "left", little_calendar: { week_placement: :none }
      )
    end

    it "registers each quarter's ID with the manifest" do
      section.register(manifest)

      expect(manifest.source?("quarter-2025-1")).to be true
      expect(manifest.source?("quarter-2025-2")).to be true
      expect(manifest.source?("quarter-2025-3")).to be true
      expect(manifest.source?("quarter-2025-4")).to be true
    end
  end

  describe "#pages" do
    let(:i18n) { class_double(I18n, "i18n") }
    let(:manifest) { LYP::Planners::MOS::Manifest.new }
    let(:little_calendar) { { week_placement: :none } }
    let(:quarter_dates) { %w[2025-01-01 2025-04-01 2025-07-01 2025-10-01] }

    let(:configurator) do
      instance_double(
        LYP::Planners::MOS::Configurator,
        start_date: make_day("2025-01-01"),
        end_date: make_day("2025-12-31")
      )
    end

    let(:section) do
      described_class.new(
        name: "quarterly", i18n:, configurator:,
        months_column: "left", little_calendar:
      )
    end

    let(:expected) do
      quarter_dates.each_with_index.map do |date, i|
        LYP::Planners::MOS::PageData.new(
          title: "title-q#{i + 1}",
          content: "content-q#{i + 1}",
          highlight_quarters: [make_quarter(date)]
        )
      end
    end

    before do
      quarter_dates.each_with_index do |date, i|
        quarter = make_quarter(date)
        page_double = instance_double(
          LYP::Planners::MOS::Pages::Quarterly,
          title: "title-q#{i + 1}",
          content: "content-q#{i + 1}"
        )
        allow(LYP::Planners::MOS::Pages::Quarterly).to receive(:new).with(
          i18n:, manifest:, quarter:, months_column: :left, little_calendar:
        ).and_return(page_double)
      end
    end

    it "returns one PageData per quarter with correct fields" do
      expect(section.pages(manifest)).to eq(expected)
    end
  end

  describe "constructor" do
    let(:i18n) { class_double(I18n, "i18n") }
    let(:configurator) { instance_double(LYP::Planners::MOS::Configurator) }

    it "accepts and ignores extra keyword arguments" do
      expect do
        described_class.new(
          name: "quarterly", i18n:, configurator:,
          months_column: "left", little_calendar: { week_placement: :none },
          manifest: LYP::Planners::MOS::Manifest.new, extra_param: "ignored"
        )
      end.not_to raise_error
    end
  end
end
