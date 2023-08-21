# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualHeader < Component
          def generate(_months)
            "#{TeX::TextSize.new(year).huge}\\hfill{}#{table_to_the_right}\n\\medskip\n\n"
          end

          private

          def year
            Date.parse(param(:start_date)).year
          end

          def table_to_the_right
            table = TeX::Tabular.new
            table.add_row([TeX::Cell.new('Calendar').selected, 'here', 'there'])

            table
          end
        end
      end
    end
  end
end
