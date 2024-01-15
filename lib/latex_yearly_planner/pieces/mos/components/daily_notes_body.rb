# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class DailyNotesBody < Component
          def generate(_page, _day)
            XTeX::Notes.new(**struct(:notes))
          end
        end
      end
    end
  end
end
