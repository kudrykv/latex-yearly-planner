# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualBody < Component
          def generate(months)
            page = ''
            months_number = months.size

            months.each_slice(section_config.parameters.columns).each do |slice|
              page += slice.map do |month|
                LatexYearlyPlanner::XTeX::CalendarLittle.new(month, **calendar_options)
              end.map(&:to_s).join('\\hfill{}')
              page += separator(months_number)
            end

            page
          end

          private

          def calendar_options
            {
              width: column_width,
              show_week_numbers: param(:show_week_numbers),
              week_number_placement: param(:week_number_placement),
              row_spacing: config.parameters.parameters.little_calendar.row_spacing,
              column_spacing: config.parameters.parameters.little_calendar.column_spacing
            }
          end

          def separator(months_number)
            return "\n\\vfill{}\n\n" if months_number == months_per_page

            "\n\\vspace{#{underfull_vertical_spacing}}\n\n"
          end

          def column_width
            param(:column_width)
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
