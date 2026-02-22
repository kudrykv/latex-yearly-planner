# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      class Planner
        attr_accessor :i18n, :overseer, :manifest, :pages,
                      :side_menu_position,
                      :side_menu_width,
                      :heading_height,
                      :heading_align,
                      :title_font_size,
                      :weekday_start,
                      :start_date,
                      :end_date,
                      :content_and_side_menu_gutter

        def initialize(i18n:, overseer:, manifest:)
          self.i18n = i18n
          self.overseer = overseer
          self.manifest = manifest
          self.pages = []

          self.content_and_side_menu_gutter = overseer.dig!(:planner, :params, :layout, :content_and_side_menu_gutter)
          self.side_menu_position = overseer.dig!(:planner, :params, :mos_layout, :side_menu_position)
          self.side_menu_width = overseer.dig!(:planner, :params, :mos_layout, :side_menu_width)
          self.heading_height = overseer.dig!(:planner, :params, :heading, :height)
          self.heading_align = overseer.dig!(:planner, :params, :heading, :align)
          self.title_font_size = overseer.dig!(:planner, :params, :heading, :title_font_size)

          self.weekday_start = overseer.weekday_start
          self.start_date = overseer.start_date
          self.end_date = overseer.end_date
        end

        def generate
          <<~TYPST.strip
            #{definition(overseer)}
            #{pages.join("\n#pagebreak()\n")}
          TYPST
        end

        def add_page(title:, content:, highlight_months: [], highlight_quarters: [], **_rest)
          pages << <<~TYPST.strip
            #grid(
              columns: (#{heading_columns}),
              rows: (#{heading_height}, 1fr),
              column-gutter: #{content_and_side_menu_gutter},

              #{heading_content(title:, highlight_months:, highlight_quarters:)},
              #{content}
            )
          TYPST
        end

        def add_blank_page(typst)
          pages << typst
        end

        def heading_columns
          columns = [side_menu_width, "1fr"]
          columns.reverse! if side_menu_position == "right"
          columns.join(", ")
        end

        def heading_content(title:, highlight_months:, highlight_quarters:)
          row = [
            side_menu_cell(highlight_months:, highlight_quarters:),
            "grid.cell(align: #{heading_align}, #{heading_stack(title)})"
          ]
          row.reverse! if side_menu_position == "right"

          row.join(", ")
        end

        def side_menu_cell(highlight_months:, highlight_quarters:)
          <<~TYPST.strip
            grid.cell(
              rowspan: 2,

              rotate(
                90deg,
                origin: center + horizon,
                reflow: true,

                table(
                  columns: (1fr, 3fr),
                  rows: 1fr,
                  inset: 0pt,
                  column-gutter: 5mm,
                  stroke: 0pt,

                  #{quarters_menu(highlight_quarters:)},
                  #{months_menu(highlight_months:)},
                )
              )
            )
          TYPST
        end

        def months_menu(highlight_months:)
          menu = Components::MonthsMenu.new(i18n:, range: start_date.month..end_date.month)
          menu.highlight(highlight_months)
          menu.generate
        end

        def quarters_menu(highlight_quarters:)
          menu = Components::QuartersMenu.new(i18n:, range: start_date.quarter..end_date.quarter)
          menu.highlight(highlight_quarters)
          menu.generate
        end

        # rubocop:disable Metrics/MethodLength
        def heading_stack(title)
          direction = "rtl"
          direction = "ltr" if side_menu_position == "right"

          stack = [
            "text(size: #{title_font_size})[#{title}]",
            "text[maybe menu]"
          ]

          <<~TYPST
            stack(
              dir: #{direction},
              spacing: 1fr,
              #{stack.join(",\n")}
            )
          TYPST
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end

# rubocop:disable Metrics/MethodLength
def definition(overseer)
  <<~TYPST.strip
    #set page(
      width: #{overseer.dig!(:document, :layout, :dimensions, :width)},
      height: #{overseer.dig!(:document, :layout, :dimensions, :height)},

      margin: (
        top: #{overseer.dig!(:document, :layout, :margin, :top)},
        right: #{overseer.dig!(:document, :layout, :margin, :right)},
        bottom: #{overseer.dig!(:document, :layout, :margin, :bottom)},
        left: #{overseer.dig!(:document, :layout, :margin, :left)},
      )
    )

    #set text(
      size: #{overseer.dig!(:document, :text, :size)}
    )

    #let dotted = tiling(
      size: (5mm, 5mm),
      place(
        dx: 0.5pt,
        dy: 0.5pt,
        circle(
          radius: 0.4pt,
          fill: black
        )
      ),
    )

    #let lined = tiling(
      size: (5mm, 5mm),
      place(
        line(
          start: (0%, 6%),
          end: (100%, 6%),
          stroke: 0.4pt + luma(130)
        ),
      )
    )

    #let rect_pattern(pattern) = rect(
      width: 100%,
      height: 100%,
      fill: pattern
    )
  TYPST
end

# rubocop:enable Metrics/MethodLength
