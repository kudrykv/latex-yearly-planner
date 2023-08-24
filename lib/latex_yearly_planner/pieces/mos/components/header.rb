# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class Header < Component
          def top_table
            table = TeX::Tblr.new
            table.add_row([calendar_cell])

            table
          end

          def calendar_cell
            cell = TeX::SetCell.new('Calendar')
            cell = cell.selected if section_name == :annual

            cell
          end

          def margin_note(highlight_quarters: [], highlight_months: [])
            <<~LATEX
              \\marginnote{%
                #{quarter_table_from_months(highlight_quarters:)}
                \\\\[#{config.between_tables_spacing}]
                #{table_from_months(highlight_months:)}
              }
            LATEX
              .strip
          end

          def quarter_table_from_months(highlight_quarters:)
            table = TeX::Tblr.new(**config.quarterly_table_options)

            all_quarters.map do |quarter|
              cell = TeX::SetCell.new(quarter.name)
              cell = cell.selected if highlight_quarters.include?(quarter)

              table.add_row([cell])
            end

            table
          end

          def table_from_months(highlight_months:)
            table = TeX::Tblr.new(**config.monthly_table_options)

            all_months.each do |month|
              cell = TeX::SetCell.new(month.name[0..2].to_s)
              cell = cell.selected if highlight_months.include?(month)

              table.add_row([cell])
            end

            table
          end
        end
      end
    end
  end
end
