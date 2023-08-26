# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualBody < Component
          def generate(months)
            rows = months.each_slice(columns).map do |months_row|
              months_row.map(&method(:little_calendar)).map(&:to_s).join(hfill)
            end

            months_number = months.size
            rows.join(separator(months_number))
          end

          private

          def columns
            param(:columns)
          end

          def little_calendar(month)
            XTeX::CalendarLittle.new(month, **parameters(:little_calendar))
          end

          def separator(months_number)
            return "\n#{vfill}\n\n" if months_number == param(:months_per_page)

            "\n#{vspace(param(:underfull_vertical_spacing))}\n\n"
          end
        end
      end
    end
  end
end
