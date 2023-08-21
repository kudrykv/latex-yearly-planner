# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualBody < Component
          def generate(months)
            page = ''

            months.each_slice(section_config.parameters.columns).each do |slice|
              page += slice.map do |month|
                LatexYearlyPlanner::XTeX::CalendarLittle.new(month, **calendar_options)
              end.map(&:to_s).join('\\hfill{}')
              page += "\n\\vfill{}\n\n"
            end

            page
          end

          private

          def calendar_options
            {
              width: column_width,
              show_week_numbers: param(:show_week_numbers),
              week_number_placement: param(:week_number_placement),
            }
          end

          def column_width
            @column_width ||= param(:column_width)
          end
        end
      end
    end
  end
end
