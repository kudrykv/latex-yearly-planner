# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Components
        class AnnualBody < Component
          def generate(months_rows)
            months_rows
              .map(&method(:months_row))
              .join("\n\n")
          end

          private

          def months_row(row)
            row.map { |month| XTeX::LittleCalendar.new(month:, **little_calendar_parameters) }
          end

          def little_calendar_parameters
            params.object(:little_calendar).to_h
          end
        end
      end
    end
  end
end
