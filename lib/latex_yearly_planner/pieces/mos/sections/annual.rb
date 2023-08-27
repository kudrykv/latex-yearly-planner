# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class Annual < Section
          def generate

            pages = all_months.each_slice(param(:months_per_page)).map do |months|
              "#{header.generate}#{body.generate(months)}"
            end

            Core::Entities::Note.new('annual', "#{pages.join("\n\\pagebreak{}\n\n")}\n\\pagebreak{}")
          end
        end
      end
    end
  end
end
