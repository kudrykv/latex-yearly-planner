# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        module Pages
          class Weekly
            attr_accessor :overseer, :week

            def initialize(overseer:, week:)
              self.overseer = overseer
              self.week = week
            end

            def generate
              <<~TYPST
                #grid(
                  columns: (5mm, 1fr),
                  rows: (auto, auto),
                grid.cell(rowspan: 2, ""), text[Week #{week}<#{week.id}>],
                text[do the layout]
                )
              TYPST
            end
          end
        end
      end
    end
  end
end
