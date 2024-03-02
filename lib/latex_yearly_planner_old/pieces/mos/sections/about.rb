# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class About < Section
          def generate
            Core::Entities::Note.new('about', "#{header.generate}#{body.generate}")
          end
        end
      end
    end
  end
end
