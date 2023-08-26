# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualHeader < Header
          def generate
            [
              top_table,
              TeX::HFill.new,
              TeX::TextSize.new(year).huge,
              TeX::HRule.new,
              margin_note,
              "\n",
              TeX::VSpace.new(param(:header, :skip)),
              "\n\n"
            ].join
          end

          private

          def year
            Date.parse(param(:start_date)).year
          end
        end
      end
    end
  end
end
