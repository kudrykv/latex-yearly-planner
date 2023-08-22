# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualHeader < Component
          def generate(_months)
            "#{margin_note}#{TeX::TextSize.new(year).huge}\\hfill{}#{table_to_the_right}\\medskip\\hrule{}\n"
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

          def margin_note
            <<~LATEX
              \\marginnote{%
                \\rotatebox{90}{%
                  hello world%
                }%
              }
            LATEX
              .strip
          end
        end
      end
    end
  end
end
