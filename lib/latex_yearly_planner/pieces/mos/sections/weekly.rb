# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class Weekly < Section
          def generate
            pages = all_weeks.map { |week| "#{header.generate(week)}#{body.generate(week)}" }

            Core::Entities::Note.new('weekly', pages.join("\n\\pagebreak{}\n\n"))
          end
        end
      end
    end
  end
end
