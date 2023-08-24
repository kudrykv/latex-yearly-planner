# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class Monthly < Section
          def generate
            pages = all_months.map { |month| "#{header.generate(month)}#{body.generate(month)}" }

            Core::Entities::Note.new('monthly', pages.join("\n\\pagebreak{}\n\n"))
          end
        end
      end
    end
  end
end
