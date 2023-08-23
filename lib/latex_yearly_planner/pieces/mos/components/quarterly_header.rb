# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class QuarterlyHeader < Header
          def generate
            "#{top_table}" \
              '\\hfill{}' \
              "#{title}" \
              '\\hrule{}' \
              "#{margin_note}" \
              "\\medskip\n"
          end

          def title
            'quarterly header'
          end
        end
      end
    end
  end
end
