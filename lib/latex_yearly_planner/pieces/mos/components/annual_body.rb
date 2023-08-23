# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualBody < Component
          def generate(months)
            rows = months.each_slice(section_config.parameters.columns).map do |slice|
              slice
                .map { |month| LatexYearlyPlanner::XTeX::CalendarLittle.new(month, **calendar_options) }
                .map(&:to_s)
                .join('\\hfill{}')
            end

            months_number = months.size
            rows.join(separator(months_number))
          end

          private

          def calendar_options
            config.little_calendar(section_name)
          end

          def separator(months_number)
            return "\n\\vfill{}\n\n" if months_number == months_per_page

            "\n\\vspace{#{underfull_vertical_spacing}}\n\n"
          end

          def months_per_page
            param(:months_per_page)
          end

          def underfull_vertical_spacing
            param(:underfull_vertical_spacing)
          end
        end
      end
    end
  end
end
