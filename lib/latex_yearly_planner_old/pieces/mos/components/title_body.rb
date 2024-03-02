# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class TitleBody < Component
          def generate
            <<~LATEX
              #{TeX::VSpace.new(fill, with_star: true)}
              #{hfill}#{TeX::ResizeBox.new(name, height:)}
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
