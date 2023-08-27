# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualBody < Component
          def generate(_page, months)
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
            XTeX::CalendarLittle.new(month, **struct(:little_calendar))
          end

          def separator(months_number)
            return [nl, vfill, nlnl].join if months_number == param(:months_per_page)

            [nl, vspace(param(:underfull_vertical_spacing)), nlnl].join
          end
        end
      end
    end
  end
end
