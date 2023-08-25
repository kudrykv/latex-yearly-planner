# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualBody < Component
          def generate(months)
            rows = months.each_slice(columns).map do |months_row|
              months_row.map(&method(:little_calendar)).map(&:to_s).join('\\hfill{}')
            end

            months_number = months.size
            rows.join(separator(months_number))
          end

          private

          def columns
            param(:columns)
          end

          def little_calendar(month)
            XTeX::CalendarLittle.new(month, **param(:little_calendar, :parameters_as_a_hash))
          end

          def separator(months_number)
            return "\n\\vfill{}\n\n" if months_number == months_per_page

            "\n\\vspace{#{underfull_vertical_spacing}}\n\n"
          end

          def months_per_page
            param(:months_per_page)
          end

          def underfull_vertical_spacing
            param(:underfull_vertical_spacing)
          end
        end
      end
    end
  end
end
