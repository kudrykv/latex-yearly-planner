# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Components
        class AnnualBody < Component
          def generate(months_rows)
            months_rows
              .map { |row| row.map(&:moment).join(' ') }
              .join("\n\n")
          end
        end
      end
    end
  end
end
