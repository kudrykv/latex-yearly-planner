# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class Annual < Section
          def generate
            LatexYearlyPlanner::Core::Entities::Note.new('annual', 'annual')
          end
        end
      end
    end
  end
end
