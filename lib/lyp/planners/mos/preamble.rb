# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      class Preamble
        def initialize(configurator)
          self.configurator = configurator
          self.dimensions = configurator.dig!(:document, :layout, :dimensions)
          self.margin = configurator.dig!(:document, :layout, :margin)
          self.planner_params = configurator.dig!(:planner, :params)
        end

        # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        def generate
          <<~TYPST.strip
            #set page(
              width: #{dimensions.dig!(:width)},
              height: #{dimensions.dig!(:height)},

              margin: (
                top: #{margin.dig!(:top)},
                right: #{margin.dig!(:right)},
                bottom: #{margin.dig!(:bottom)},
                left: #{margin.dig!(:left)},
              )
            )

            #set text(
              size: #{configurator.dig!(:document, :text, :size)}
            )

            #let regular_stroke = #{planner_params.dig!(:regular_stroke)}
            #let thick_stroke = #{planner_params.dig!(:thick_stroke)}
            #let regular_height = #{planner_params.dig!(:regular_height)}
            #let regular_column_gutter = #{planner_params.dig!(:regular_column_gutter)}

            #let h1 = #{configurator.dig!(:document, :text, :h1)}

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

            #let scratch_pad = rect_pattern(#{planner_params.dig!(:scratch_pad)})

            #let padded_link(padding: #{planner_params.dig!(:link_padding)}, target, content) = box(
              inset: -padding,
              link(target)[#box(inset: padding, content)]
            )
          TYPST
        end
        # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

        private

        attr_accessor :configurator, :dimensions, :margin, :planner_params
      end
    end
  end
end
