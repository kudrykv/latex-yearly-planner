# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class Annual < Section
          def generate
            pages = 1.upto(param(:pages)).map { |page_number| page_iteration(page_number) }

            Core::Entities::Note.new('annual', "#{pages.join("\n\\pagebreak{}\n\n")}\n\\pagebreak{}")
          end

          private

          def page_iteration(page_number)
            months = all_months.each_slice(param(:months_per_page)).take(page_number).last

            "#{header.generate}#{body.generate(months)}"
          end
        end
      end
    end
  end
end
