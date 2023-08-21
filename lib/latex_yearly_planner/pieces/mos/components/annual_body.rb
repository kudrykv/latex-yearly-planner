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
                LatexYearlyPlanner::XTeX::CalendarLittle.new(month)
              end.map(&:to_s).join('\\hfill{}')
              page += "\n\\vfill{}\n\n"
            end

            page
          end
        end
      end
    end
  end
end
