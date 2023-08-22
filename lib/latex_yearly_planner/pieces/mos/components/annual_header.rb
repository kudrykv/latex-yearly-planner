# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualHeader < Component
          def generate(all_months, _months)
            "#{margin_note(all_months)}" \
              "#{TeX::TextSize.new(year).huge}" \
              '\\hfill{}' \
              "#{table_to_the_right}" \
              "\\medskip\\hrule{}\n"
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

          def margin_note(all_months)
            <<~LATEX
              \\marginnote{%
                %\\rotatebox[origin=tr]{90}{%
                #{table_from_months(all_months)}
                %}%
              }
            LATEX
              .strip
          end

          def table_from_months(months)
            table = TeX::Tabular.new(vertical_padding_factor:)
            table.format = "P{#{config.document.layout.margin_notes.width}}"
            table.horizontal_lines = true

            months.each do |month|
              table.add_row([month.name[0..2]])
            end

            table
          end

          def vertical_padding_factor
            config.parameters.parameters.header.vertical_padding_factor
          end
        end
      end
    end
  end
end
