# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        class Planner
          attr_accessor :overseer

          def initialize(overseer:)
            self.overseer = overseer
          end

          def generate
            definition(overseer)
          end
        end
      end
    end
  end
end

def definition(overseer)
  <<~TYPST.strip
    #set page(
      width: #{overseer.dig(:document, :layout, :dimensions, :width)},
      height: #{overseer.dig(:document, :layout, :dimensions, :height)},

      margin: (
        top: #{overseer.dig(:document, :layout, :margin, :top)},
        right: #{overseer.dig(:document, :layout, :margin, :right)},
        bottom: #{overseer.dig(:document, :layout, :margin, :bottom)},
        left: #{overseer.dig(:document, :layout, :margin, :left)},
      )
    )

    #set text(
      size: #{overseer.dig(:document, :text, :size)}
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

