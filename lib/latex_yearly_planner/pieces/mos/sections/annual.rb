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

            "#{header.generate(months)}#{body.generate(months)}"
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

          def make_months_range(from_month, to_month)
            (from_month..to_month).select { |date| date.mday == 1 }.map do |date|
              LatexYearlyPlanner::Calendar::Month.new(date, weekday_start:, show_week_numbers:)
            end
          end

          def start_month
            @start_month ||= Date.parse(config.parameters.parameters.start_date)
          end

          def end_month
            @end_month ||= Date.parse(config.parameters.parameters.end_date)
          end

          def weekday_start
            @weekday_start ||= param(:weekday_start).downcase.to_sym
          end

          def show_week_numbers
            @show_week_numbers ||= param(:show_week_numbers)
          end
        end
      end
    end
  end
end
