# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class Annual < Section
          def generate
            pages = 1.upto(annual_pages).map { |page_number| page_iteration(page_number) }

            LatexYearlyPlanner::Core::Entities::Note.new('annual', pages.join("\n\\pagebreak{}\n\n"))
          end

          private

          def page_iteration(page_number)
            months = all_months.each_slice(months_per_page).take(page_number).last

            "#{header.generate}#{body.generate(months)}"
          end

          def annual_pages
            section_config.parameters.pages
          end

          def months_per_page
            section_config.parameters.months_per_page
          end
        end
      end
    end
  end
end
