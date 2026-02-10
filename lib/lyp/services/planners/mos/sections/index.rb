# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        module Sections
          class Index
            attr_accessor :overseer

            def initialize(overseer:)
              self.overseer = overseer
            end

            def generate
              definition = <<~TYPST.strip
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
              TYPST

              "#{definition}\n\n"
            end
          end
        end
      end
    end
  end
end
