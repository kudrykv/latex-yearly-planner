# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class Quarterly < Section
          def generate
            LatexYearlyPlanner::Core::Entities::Note.new('quarterly', "#{header.generate}#{body.generate}")
          end
        end
      end
    end
  end
end
