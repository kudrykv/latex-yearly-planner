# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class MonthlyBody < Component
          def generate(month)
            XTeX::CalendarLarge.new(month, **parameters(:large_calendar)).to_s
          end
        end
      end
    end
  end
end
