# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Components
        class AnnualHeader < Component
          def generate(...)
            params.quarters

            <<~LATEX
                            \\marginnote{%
              \\begin{tabularx}{\\linewidth}{|@{}X@{}|}
                Hai \\\\
              \\end{tabularx}
              }
            LATEX
              .strip
          end
        end
      end
    end
  end
end
