# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualHeader < Component
          def generate(all_months, _months)
            "#{TeX::TextSize.new(year).huge}" \
              '\\hfill{}' \
              "#{table_to_the_right}" \
              '\\hrule{}' \
              "#{margin_note(all_months)}" \
              "\\medskip\n"
          end

          private

          def year
            Date.parse(param(:start_date)).year
          end

          def table_to_the_right
            table = TeX::Tblr.new
            table.add_row([TeX::SetCell.new('Calendar').selected, 'here', 'there'])

            table
          end

          def margin_note(all_months)
            <<~LATEX
              \\marginnote{%
                #{quarter_table_from_months(all_months)}
                \\\\[5mm]
                #{table_from_months(all_months)}
              }
            LATEX
              .strip
          end

          def quarter_table_from_months(months)
            table = TeX::Tblr.new(
              column_spacing:, row_spacing:, horizontal_lines: true, format: 'X[c,m]'
            )

            months.map(&:quarter).uniq(&:date).map(&:name).map do |name|
              table.add_row([name])
            end

            table
          end

          def table_from_months(months)
            table = TeX::Tblr.new(column_spacing:, row_spacing:)
            table.horizontal_lines = true
            table.format = 'X[c,m]'

            months.each do |month|
              table.add_row([month.name[0..2].to_s])
            end

            table
          end

          def row_spacing
            config.parameters.parameters.header.row_spacing
          end

          def column_spacing
            config.parameters.parameters.header.column_spacing
          end
        end
      end
    end
  end
end
