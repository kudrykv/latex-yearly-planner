# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Components
        class AnnualHeader < HeaderBase
          def generate(_months, _page_number)
            <<~LATEX.strip
              \\marginnote{#{in_margin_note}}%
              #{heading_table}%
              #{XTeX::Line.new}%
              \\vskip#{params.get(:header_separation)}
            LATEX
          end

          private

          def in_margin_note
            XTeX::MosSideNav.new(i18n:, struct: params.object(:side_navigation), quarters:, months:)
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
