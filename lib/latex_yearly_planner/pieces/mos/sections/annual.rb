# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class Annual < Section
          def generate
            pages = []

            1.upto(annual_pages) do |page_number|
              pages << page_iteration(page_number)
            end

            LatexYearlyPlanner::Core::Entities::Note.new('annual', pages.join("\n\\pagebreak{}\n\n"))
          end

          private

          def page_iteration(page_number)
            months = months_for_page(page_number)

            "#{header.generate(all_months, months)}#{body.generate(months)}"
          end

          def months_for_page(page_number)
            from = (page_number - 1) * months_per_page
            to = from + months_per_page - 1

            from_month = start_month + from.months
            to_month = start_month + to.months

            to_month = end_month if to_month > end_month

            make_months_range(from_month, to_month)
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
