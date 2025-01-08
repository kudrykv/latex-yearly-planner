# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Sections
        class DailyNotes < Section
          def pages
            params.days.map do |day|
              pages_per_day.times.map { |index| [day, index + 1] }
            end.flatten(1)
          end

          private

          def pages_per_day
            params.get(:pages_per_day) || 1
          end
        end
      end
    end
  end
end
