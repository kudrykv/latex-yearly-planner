# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Preamble do
  describe "#generate" do
    let(:dto) do
      {
        document: {
          layout: {
            dimensions: { width: "158mm", height: "210mm" },
            margin: { top: "10mm", right: "5mm", bottom: "0mm", left: "0mm" }
          },
          text: { size: "10pt", h1: "10mm" }
        },
        planner: {
          params: {
            regular_stroke: "0.4pt",
            thick_stroke: "0.8pt",
            regular_height: "5mm",
            regular_column_gutter: "10pt",
            scratch_pad: "dotted",
            link_padding: "8pt"
          }
        }
      }
    end

    let(:configurator) { LYP::Planners::MOS::Configurator.new(LYP::Pkg::StrictHash.new(dto)) }

    let(:expected) do
      <<~TYPST.strip
        #set page(
          width: 158mm,
          height: 210mm,

          margin: (
            top: 10mm,
            right: 5mm,
            bottom: 0mm,
            left: 0mm,
          )
        )

        #set text(
          size: 10pt
        )

        #let regular_stroke = 0.4pt
        #let thick_stroke = 0.8pt
        #let regular_height = 5mm
        #let regular_column_gutter = 10pt

        #let h1 = 10mm

        #let dotted = tiling(
          size: (regular_height, regular_height),
          place(
            dx: 0.5pt,
            dy: regular_height - 0.3mm,
            circle(
              radius: 0.141mm,
              fill: black
            )
          ),
        )

        #let lined = tiling(
          size: (regular_height, regular_height),
          place(
            line(
              start: (0%, regular_height - 0.15mm),
              end: (100%, regular_height - 0.15mm),
              stroke: regular_stroke + luma(130)
            ),
          )
        )

        #let rect_pattern(pattern) = rect(
          width: 100%,
          height: 100%,
          fill: pattern
        )

        #let scratch_pad = rect_pattern(dotted)

        #let padded_link(padding: 8pt, target, content) = box(
          inset: -padding,
          link(target)[#box(inset: padding, content)]
        )
      TYPST
    end

    it "returns the document preamble with the configured values" do
      expect(described_class.new(configurator).generate).to eq(expected)
    end

    it "raises ConfigError when a required key is missing" do
      dto[:document][:text].delete(:size)

      expect { described_class.new(configurator).generate }
        .to raise_error(LYP::ConfigError, /document\.text\.size/)
    end
  end
end
