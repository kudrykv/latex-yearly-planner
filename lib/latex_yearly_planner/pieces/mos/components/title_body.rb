# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class TitleBody < Component
          def generate
            <<~LATEX
              #{TeX::VSpace.new(TeX::Fill.new, with_star: true)}
              #{TeX::HFill.new}#{TeX::ResizeBox.new(name, height:)}
            LATEX
          end

          private

          def name
            param(:name)
          end

          def height
            param(:height) || '3cm'
          end
        end
      end
    end
  end
end
