# frozen_string_literal: true

RSpec.describe LYP::Planners::MOS::Navigation do
  let(:i18n) { class_double(I18n, "i18n") }
  let(:manifest) { LYP::Planners::MOS::Manifest.new }
  let(:mos_layout_extras) { {} }

  let(:dto) do
    {
      planner: {
        params: {
          start_date: "2026-01-01",
          end_date: "2026-12-31",
          weekday_start: "Monday",
          mos_layout: {
            menu_rotate: "270deg",
            reverse_months_quarters: false,
            reverse_months_quarters_items: false,
            **mos_layout_extras
          },
          heading: { height: "10mm" }
        }
      }
    }
  end

  let(:configurator) { LYP::Planners::MOS::Configurator.new(LYP::Pkg::StrictHash.new(dto)) }
  let(:navigation) { described_class.new(i18n:, manifest:, configurator:) }

  describe "#side_menu_cell" do
    let(:months_menu) { instance_double(LYP::Planners::MOS::Components::MonthsMenu, generate: "MONTHS") }
    let(:quarters_menu) { instance_double(LYP::Planners::MOS::Components::QuartersMenu, generate: "QUARTERS") }

    let(:expected) do
      <<~TYPST.strip
        grid.cell(
          rowspan: 2,

          rotate(
            270deg,
            origin: center + horizon,
            reflow: true,

            table(
              columns: (1fr, 3fr),
              rows: 1fr,
              inset: 0pt,
              column-gutter: regular_column_gutter,
              stroke: 0pt,

              QUARTERS,
        MONTHS
            )
          )
        )
      TYPST
    end

    before do
      allow(months_menu).to receive(:highlight)
      allow(quarters_menu).to receive(:highlight)
      allow(LYP::Planners::MOS::Components::MonthsMenu).to receive(:new).and_return(months_menu)
      allow(LYP::Planners::MOS::Components::QuartersMenu).to receive(:new).and_return(quarters_menu)
    end

    it "renders quarters then months at 1fr/3fr by default" do
      expect(navigation.side_menu_cell(highlight_months: [], highlight_quarters: [])).to eq(expected)
    end

    context "when reverse_months_quarters is true" do
      let(:mos_layout_extras) { { reverse_months_quarters: true } }

      let(:expected) do
        <<~TYPST.strip
          grid.cell(
            rowspan: 2,

            rotate(
              270deg,
              origin: center + horizon,
              reflow: true,

              table(
                columns: (3fr, 1fr),
                rows: 1fr,
                inset: 0pt,
                column-gutter: regular_column_gutter,
                stroke: 0pt,

                MONTHS,
          QUARTERS
              )
            )
          )
        TYPST
      end

      it "renders months then quarters at 3fr/1fr" do
        expect(navigation.side_menu_cell(highlight_months: [], highlight_quarters: [])).to eq(expected)
      end
    end
  end

  describe "#heading_menu_grid" do
    let(:annual_id) { LYP::Planners::MOS::Sections::Annual::ID }

    context "when annual is not registered as a manifest source" do
      it "returns nil so the heading nav grid is omitted (avoids columns: 0)" do
        expect(navigation.heading_menu_grid(page_id: "monthly-2026-01")).to be_nil
      end
    end

    context "when annual is registered as a source" do
      before { manifest.register_source(annual_id) }

      it "renders the highlight cell on the annual page" do
        expect(navigation.heading_menu_grid(page_id: annual_id)).to eq(<<~TYPST)
          grid(
            rows: 10mm,
            columns: 1,
            inset: 7pt,

            stroke: (x, y)  => if x > 0 { ( left: regular_stroke ) },
            grid.cell(fill: black, text(white)[#padded_link(<#{annual_id}>, [Calendar])])
          )
        TYPST
      end

      it "renders a plain padded_link on a different page" do
        expect(navigation.heading_menu_grid(page_id: "monthly-2026-01")).to eq(<<~TYPST)
          grid(
            rows: 10mm,
            columns: 1,
            inset: 7pt,

            stroke: (x, y)  => if x > 0 { ( left: regular_stroke ) },
            padded_link(<#{annual_id}>, [Calendar])
          )
        TYPST
      end
    end
  end
end
