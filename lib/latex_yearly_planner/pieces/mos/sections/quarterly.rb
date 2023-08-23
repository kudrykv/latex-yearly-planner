# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class Quarterly < Section
          def generate
            pages = all_quarters.map { |quarter| "#{header.generate(quarter)}#{body.generate(quarter)}" }

            LatexYearlyPlanner::Core::Entities::Note.new('quarterly', pages.join("\n\\pagebreak{}\n\n"))
          end
        end
      end
    end
  end
end
