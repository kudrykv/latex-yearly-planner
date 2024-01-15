# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class DailyNotes < Section
          def iterations
            all_days.map { |day| pages_number.times.map(&:succ).map { |page| [page, day] } }.flatten(1)
          end

          private

          def pages_number
            param(:pages) || 1
          end
        end
      end
    end
  end
end
