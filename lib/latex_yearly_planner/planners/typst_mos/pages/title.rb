# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Title < Page
          def generate(title)
            <<~TYPST
              #block(
                width: 100%,
                height: 100%,
                align(
                  center + horizon,
                  text(
                    size: 48pt,
                    [#{title}]
                  )
                )
              )
            TYPST
          end
        end
      end
    end
  end
end
