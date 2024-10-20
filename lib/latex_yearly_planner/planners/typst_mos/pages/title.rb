# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Title < Page
          attr_reader :title

          def set(title)
            @title = title

            self
          end

          def generate
            <<~TYPST
              #block(
                width: 100%,
                height: 100%,
                align(
                  center + horizon,
                  text(
                    size: #{params.get(:font_size)},
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
