# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class Quarterly < Section
          def generate
            pages = all_quarters.map { |quarter| "#{header.generate(quarter)}#{body.generate(quarter)}" }

            Core::Entities::Note.new('quarterly', "#{pages.join("\n\\pagebreak{}\n\n")}\n\\pagebreak{}")
          end
        end
      end
    end
  end
end
