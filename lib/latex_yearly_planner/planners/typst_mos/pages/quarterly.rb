# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Quarterly < Face
          def title(quarter, _page_number)
            <<~TYPST
              [Q#{quarter.number}]
            TYPST
          end

          def content(...)
            '[]'
          end
        end
      end
    end
  end
end
