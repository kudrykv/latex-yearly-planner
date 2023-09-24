# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class TitleBody < Component
          def generate
            <<~LATEX
              \\vspace*{\\fill}
              \\hfill\\resizebox{!}{3cm}{2023}
            LATEX
          end
        end
      end
    end
  end
end
