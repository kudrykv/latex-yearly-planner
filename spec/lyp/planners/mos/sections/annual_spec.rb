# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Sections::Annual do
  describe "#section_name" do
    let(:configurator) { make_configurator }
    let(:i18n) { class_double(I18n, "i18n") }
    let(:section) do
      described_class.new(section_name: "annual", i18n:, configurator:, little_calendar: { week_placement: :none })
    end

    it "returns the name" do
      expect(section.section_name).to eq("annual")
    end
  end

  describe "#register" do
    let(:configurator) { make_configurator }
    let(:i18n) { class_double(I18n, "i18n") }
    let(:manifest) { LYP::Planners::MOS::Manifest.new }
    let(:section) do
      described_class.new(section_name: "annual", i18n:, configurator:, little_calendar: { week_placement: :none })
    end

    it "registers Sections::Annual::ID as a source" do
      section.register(manifest)

      expect(manifest.source?(described_class::ID)).to be true
    end
  end

  describe "#pages" do
    let(:i18n) { class_double(I18n, "i18n") }
    let(:manifest) { LYP::Planners::MOS::Manifest.new }

    let(:configurator) { make_configurator(start_date: "2026-01-01", end_date: "2026-12-31") }

    let(:section) do
      described_class.new(section_name: "annual", i18n:, configurator:, little_calendar: { week_placement: :none })
    end

    let(:expected) do
      LYP::Planners::MOS::PageData.new(
        content: expected_content,
        title: "text(size: h1)[Calendar<#{described_class::ID}>]",
        page_id: LYP::Planners::MOS::Sections::Annual::ID
      )
    end

    let(:expected_content) do
      <<~TYPST.strip
        grid(
          columns: (1fr, 1fr, 1fr),
          rows: 1fr,
          column-gutter: 10pt,
          row-gutter: 5pt,

          [cal-1],
        [cal-2],
        [cal-3],
        [cal-4],
        [cal-5],
        [cal-6],
        [cal-7],
        [cal-8],
        [cal-9],
        [cal-10],
        [cal-11],
        [cal-12]
        )
      TYPST
    end

    before do
      (configurator.start_date.month..configurator.end_date.month).each_with_index do |month, i|
        calendar = instance_double(
          LYP::Planners::MOS::Components::LittleCalendar,
          generate: "[cal-#{i + 1}]"
        )
        allow(LYP::Planners::MOS::Components::LittleCalendar).to receive(:new).with(
          i18n:, manifest:, month:, week_placement: :none
        ).and_return(calendar)
      end
    end

    it "returns one PageData with calendar grid content" do
      expect(section.pages(manifest)).to eq([expected])
    end
  end

  it "accepts and ignores extra keyword arguments" do
    expect do
      described_class.new(
        section_name: "annual",
        i18n: class_double(I18n, "i18n"),
        configurator: make_configurator,
        little_calendar: { week_placement: :none },
        manifest: LYP::Planners::MOS::Manifest.new,
        extra_param: "ignored"
      )
    end.not_to raise_error
  end
end
