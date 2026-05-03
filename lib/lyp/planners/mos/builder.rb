# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      class Builder
        def initialize(i18n:, configurator:, manifest:)
          self.configurator = configurator
          self.pages = []
          self.preamble = Preamble.new(configurator)
          self.navigation = Navigation.new(i18n:, manifest:, configurator:)
          self.mos_layout = configurator.dig!(:planner, :params, :mos_layout)
          self.heading = configurator.dig!(:planner, :params, :heading)
        end

        def generate
          <<~TYPST.strip
            #{preamble.generate}
            #{pages.join("\n#pagebreak()\n")}
          TYPST
        end

        def add(page_spec)
          pages << (page_spec.raw_typst? ? page_spec.content : layout_page(page_spec))
        end

        private

        attr_accessor :configurator, :pages, :preamble, :navigation, :mos_layout, :heading

        def layout_page(page_spec)
          <<~TYPST.strip
            #grid(
              columns: (#{heading_columns}),
              rows: (#{heading.dig!(:height)}, 1fr),
              column-gutter: #{mos_layout.dig!(:column_gutter)},
              row-gutter: #{mos_layout.dig!(:row_gutter)},
              #{"stroke: regular_stroke," if configurator.debug?}

              #{heading_content(
                title: page_spec.title,
                highlight_months: page_spec.highlight_months,
                highlight_quarters: page_spec.highlight_quarters,
                page_id: page_spec.page_id
              )},
              #{page_spec.content}
            )
          TYPST
        end

        def heading_columns
          columns = [mos_layout.dig!(:side_menu_width), "1fr"]
          columns.reverse! if mos_layout.dig!(:side_menu_position) == "right"
          columns.join(", ")
        end

        def heading_content(title:, page_id:, highlight_months:, highlight_quarters:)
          row = [
            navigation.side_menu_cell(highlight_months:, highlight_quarters:),
            "grid.cell(align: #{heading.dig!(:align)}, #{heading_stack(page_id:, title:)})"
          ]
          row.reverse! if mos_layout.dig!(:side_menu_position) == "right"

          row.join(", ")
        end

        def heading_stack(page_id:, title:)
          <<~TYPST
            stack(
              dir: #{mos_layout.dig!(:side_menu_position) == "right" ? "ltr" : "rtl"},
              spacing: 1fr,
              #{[title, navigation.heading_menu_grid(page_id:)].compact.join(",\n")}
            )
          TYPST
        end
      end
    end
  end
end
