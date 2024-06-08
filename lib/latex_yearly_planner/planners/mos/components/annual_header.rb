# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Components
        class AnnualHeader < Component
          def generate(_months, _page_number)
            <<~LATEX
              \\marginnote{#{in_margin_note}}%
              #{heading_table}%
              #{XTeX::Line.new}%
              \\vskip#{params.get(:header_separation)}
            LATEX
              .strip
          end

          private

          def in_margin_note
            XTeX::MosNav.new(
              i18n:,
              navigation: params.object(:side_navigation).placements,
              quarters: params.quarters,
              quarters_navigation_params: params.object(:side_navigation).objects.quarter_navigation.to_h,
              months: params.months,
              months_navigation_params: params.object(:side_navigation).objects.month_navigation.to_h
            )
          end

          def heading_table
            XTeX::MosHeadingTable.new(
              page_name:,
              placement: params.placement(:heading),
              tabularx: params.object(:heading).tabularx,
              navigation:
            )
          end

          def page_name
            TeX::TableCell.new(heading_name)
          end

          def heading_name
            first = params.months.first
            last = params.months.last

            return first.year if first.year == last.year && first.january? && last.december?

            "#{first.year}, #{short_month_name(first)} -- #{last.year}, #{short_month_name(last)}"
          end

          def navigation
            [TeX::TableCell.new('one'), TeX::TableCell.new('two')]
          end
        end
      end
    end
  end
end
