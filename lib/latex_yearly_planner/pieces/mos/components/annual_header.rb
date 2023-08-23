# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualHeader < Component
          def generate(all_months, _months)
            "#{top_table}" \
              '\\hfill{}' \
                "#{title}" \
              '\\hrule{}' \
              "#{margin_note(all_months)}" \
              "\\medskip\n"
          end

          private

          def title
            TeX::TextSize.new(year).huge
          end

          def year
            Date.parse(param(:start_date)).year
          end

          def top_table
            table = TeX::Tblr.new
            table.add_row([TeX::SetCell.new('Calendar').selected])

            table
          end

          def margin_note(all_months)
            <<~LATEX
              \\marginnote{%
                #{quarter_table_from_months(all_months)}
                \\\\[#{config.between_tables_spacing}]
                #{table_from_months(all_months)}
              }
            LATEX
              .strip
          end

          def quarter_table_from_months(months)
            table = TeX::Tblr.new(**config.quarterly_table_options)

            months.map(&:quarter).uniq(&:date).map(&:name).map do |name|
              table.add_row([name])
            end

            table
          end

          def table_from_months(months)
            table = TeX::Tblr.new(**config.monthly_table_options)

            months.each do |month|
              table.add_row([month.name[0..2].to_s])
            end

            table
          end
        end
      end
    end
  end
end
