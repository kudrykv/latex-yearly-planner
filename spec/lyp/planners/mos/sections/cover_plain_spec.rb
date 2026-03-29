# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Sections::CoverPlain do
  describe "#registered_section_name" do
    let(:section) { described_class.new(name: "My Planner", font_size: "24pt") }

    it "returns the name" do
      expect(section.registered_section_name).to eq("My Planner")
    end
  end

  describe "#register" do
    let(:section) { described_class.new(name: "My Planner", font_size: "24pt") }
    let(:manifest) { instance_double(LYP::Planners::MOS::Manifest) }

    it "does not interact with the manifest" do
      expect { section.register(manifest) }.not_to raise_error
    end
  end

  describe "#pages" do
    let(:manifest) { instance_double(LYP::Planners::MOS::Manifest) }
    let(:section) { described_class.new(name: "My Planner 2026", font_size: "24pt") }

    let(:expected_content) do
      <<~TYPST.strip
        #grid(
          columns: 1fr,
          rows: 1fr,
          align: center + horizon,
          stroke: 0pt,

          text(size: 24pt)[My Planner 2026]
        )
      TYPST
    end

    let(:expected) do
      LYP::Planners::MOS::PageData.new(
        raw_typst: true,
        content: expected_content,
        title: nil,
        highlight_months: [],
        highlight_quarters: []
      )
    end

    it "returns one PageData with raw typst cover content" do
      expect(section.pages(manifest)).to eq([expected])
    end
  end

  it "accepts and ignores extra keyword arguments" do
    expect do
      described_class.new(
        name: "Test", font_size: "24pt",
        i18n: instance_double(Object), manifest: instance_double(Object),
        overseer: instance_double(Object), extra_param: "ignored"
      )
    end.not_to raise_error
  end
end
