# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Breadcrumbs
      module Components
        class TitleBody < Component
          def generate
            <<~LATEX
              \\vspace*{\\fill}
              \\hfill\\resizebox{!}{3cm}{#{param(:name)}}
            LATEX
          end
        end
      end
    end
  end
end
