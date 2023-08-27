# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class IndexNotesHeader < Header
          def generate_index(page)
            [
              top_table,
              hfill,
              index_title(page),
              hrule,
              margin_note,
              nl,
              vspace(param(:header, :skip)),
              nlnl
            ].join
          end

          def generate_notes(page)
            'header notes'
          end

          private

          def index_title(page)
            TeX::TextSize.new('Index').huge
          end
        end
      end
    end
  end
end
