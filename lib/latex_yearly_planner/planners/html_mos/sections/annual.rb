# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module HtmlMos
      module Sections
        class Annual < Section
          def pages
            months
              .each_slice(months_per_page)
              .map { |months| months.each_slice(months_per_row).to_a }
          end

          private

          def months
            params.months
          end

          def months_per_page
            params.get(:months_per_page)
          end

          def months_per_row
            params.get(:months_per_row)
          end
        end
      end
    end
  end
end
