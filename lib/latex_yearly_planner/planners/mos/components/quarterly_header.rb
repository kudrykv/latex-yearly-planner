# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Components
        class QuarterlyHeader < HeaderBase
          def generate(quarter, _page_number)
            <<~LATEX.strip
              \\marginnote{#{in_margin_note}}%
              #{heading_table(quarter:)}%
              #{XTeX::Line.new}%
              \\vskip#{params.get(:header_separation)}
            LATEX
          end

          def in_margin_note
            XTeX::MosSideNav.new(i18n:, struct: params.object(:side_navigation), quarters:, months:)
          end

          def heading_table(quarter:)
            XTeX::MosHeadingTable.new(struct: params.object(:heading_table), page_name: page_name(quarter), navigation:)
          end

          def page_name(quarter)
            "#{i18n.translate('calendar.one_letter.quarter')}#{quarter.number}"
          end

          def navigation
            ['Calendar']
          end
        end
      end
    end
  end
end
