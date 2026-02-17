# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        class Planner
          attr_accessor :overseer, :pages
          attr_accessor :side_menu_position, :side_menu_width, :heading_height

          def initialize(overseer:)
            self.overseer = overseer
            self.pages = []

            self.side_menu_position = overseer.dig!(:planner, :objects, :mos_layout, :side_menu_position)
            self.side_menu_width = overseer.dig!(:planner, :objects, :mos_layout, :side_menu_width)
            self.heading_height = overseer.dig!(:planner, :objects, :mos_layout, :heading_height)
          end

          def generate
            "#{definition(overseer)}\n#{pages.join(glue)}"
          end

          def add_page(title:, content:, **_rest)
            pages << <<~TYPST
              #grid(
                columns: (#{heading_columns}),
                rows: (#{heading_height}, 1fr),
                stroke: 0.4pt,

                #{heading_content(title)},
                text[#{content}]
              )
            TYPST
          end

          def heading_columns
            columns = [side_menu_width, '1fr']
            columns.reverse! if side_menu_position == 'right'
            columns.join(', ')
          end

          def heading_content(title)
            row = ["grid.cell(rowspan: 2, text[side menu will be here])", "text[#{title}]"]
            row.reverse! if side_menu_position == 'right'

            row.join(', ')
          end

          def glue = "#pagebreak()\n"
        end
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
