# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class Title < Section
          def generate
            LatexYearlyPlanner::Core::Entities::Note.new('title', "#{header.generate}#{body.generate}")
          end
        end
      end
    end
  end
end
