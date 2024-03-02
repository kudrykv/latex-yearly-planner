# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AboutHeader < Component
          def generate
            '\section*{About}'
          end
        end
      end
    end
  end
end
