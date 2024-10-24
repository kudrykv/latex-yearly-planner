# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Sections
        class NotesIndex < Section
          def pages
            (1..params.get(:pages))
          end
        end
      end
    end
  end
end
