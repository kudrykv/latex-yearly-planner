# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Sections::Daily do
  describe "#registered_section_name" do
    let(:i18n) { class_double(I18n, "i18n") }
    let(:overseer) { instance_double(LYP::Planners::MOS::Configurator) }

    let(:section) do
      described_class.new(name: "daily", i18n:, overseer:, columns_width: "(3fr, 2fr)")
    end

    it "returns the name" do
      expect(section.registered_section_name).to eq("daily")
    end
  end

  describe "#register" do
    let(:i18n) { class_double(I18n, "i18n") }
    let(:manifest) { LYP::Planners::MOS::Manifest.new }

    let(:overseer) do
      instance_double(
        LYP::Planners::MOS::Configurator,
        start_date: make_day("2024-03-11"),
        end_date: make_day("2024-03-14"),
        debug?: false
      )
    end

    let(:section) do
      described_class.new(name: "daily", i18n:, overseer:, columns_width: "(3fr, 2fr)")
    end

    it "registers each day's ID with the manifest" do
      section.register(manifest)

      expect(manifest.source?("2024-03-11")).to be true
      expect(manifest.source?("2024-03-12")).to be true
      expect(manifest.source?("2024-03-13")).to be true
      expect(manifest.source?("2024-03-14")).to be true
    end
  end

  describe "#pages" do
    let(:i18n) { class_double(I18n, "i18n") }
    let(:manifest) { LYP::Planners::MOS::Manifest.new }
    let(:day_ids) { %w[2024-03-11 2024-03-12 2024-03-13 2024-03-14] }
    let(:march) { make_month("2024-03") }
    let(:q1) { make_quarter("2024-01-01") }

    let(:overseer) do
      instance_double(
        LYP::Planners::MOS::Configurator,
        start_date: make_day("2024-03-11"),
        end_date: make_day("2024-03-14"),
        debug?: false
      )
    end

    let(:section) do
      described_class.new(
        name: "daily", i18n:, overseer:,
        columns_width: "(3fr, 2fr)", column_gutter: "4mm"
      )
    end

    let(:expected) do
      day_ids.map do |id|
        LYP::Planners::MOS::PageData.new(
          title: "title-#{id}",
          content: "content-#{id}",
          highlight_months: [march],
          highlight_quarters: [q1]
        )
      end
    end

    before do
      allow(LYP::Planners::MOS::Pages::Daily).to receive(:new) do |**kwargs|
        instance_double(
          LYP::Planners::MOS::Pages::Daily,
          title: "title-#{kwargs[:day].id}",
          content: "content-#{kwargs[:day].id}"
        )
      end
    end

    it "returns one PageData per day with correct fields" do
      expect(section.pages(manifest)).to eq(expected)
    end
  end

  describe "constructor" do
    let(:i18n) { class_double(I18n, "i18n") }

    let(:overseer) do
      instance_double(
        LYP::Planners::MOS::Configurator,
        start_date: make_day("2024-03-11"),
        end_date: make_day("2024-03-14"),
        debug?: false
      )
    end

    it "accepts extra keyword arguments without raising" do
      expect do
        described_class.new(
          name: "daily", i18n:, overseer:,
          columns_width: "(3fr, 2fr)", extra_param: "captured"
        )
      end.not_to raise_error
    end
  end
end
