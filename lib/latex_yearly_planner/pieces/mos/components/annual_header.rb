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
            table.add_row([TeX::SetCell.new('Calendar').selected])

            table
          end

          def margin_note(all_months)
            <<~LATEX
              \\marginnote{%
                #{quarter_table_from_months(all_months)}
                \\\\[#{between_tables_spacing}]
                #{table_from_months(all_months)}
              }
            LATEX
              .strip
          end

          def quarter_table_from_months(months)
            table = TeX::Tblr.new(**quarterly_table_options)

            months.map(&:quarter).uniq(&:date).map(&:name).map do |name|
              table.add_row([name])
            end

            table
          end

          def table_from_months(months)
            table = TeX::Tblr.new(**monthly_table_options)

            months.each do |month|
              table.add_row([month.name[0..2].to_s])
            end

            table
          end

          def quarterly_table_options
            config.parameters.parameters.header.quarterly_table_as_a_hash
          end

          def monthly_table_options
            config.parameters.parameters.header.monthly_table_as_a_hash
          end

          def between_tables_spacing
            config.parameters.parameters.header.between_tables_spacing
          end
        end
      end
    end
  end
end
