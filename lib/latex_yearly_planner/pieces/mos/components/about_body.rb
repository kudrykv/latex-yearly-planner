# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AboutBody < Component
          def generate
            <<~LATEX
              This is the configuration that was used to build the planner.
              
              SHA: #{sha}
              Config:
              \\begin{multicols}{2}\\begin{tiny}\\begin{verbatim}
              #{config.struct.to_h.deep_stringify_keys.to_yaml}
              \\end{verbatim}\\end{tiny}\\end{multicols}

              https://github.com/kudrykv/latex-yearly-planner $\\heartsuit$ #{current_year}
            LATEX
          end

          private

          def sha
            `git rev-parse HEAD || echo "unknown"`
          end

          def current_year
            Time.now.year
          end
        end
      end
    end
  end
end
