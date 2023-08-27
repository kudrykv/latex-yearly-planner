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
            [
              top_table,
              hfill,
              notes_title(page),
              hrule,
              margin_note,
              nl,
              vspace(param(:header, :skip)),
              nlnl
            ].join
          end

          private

          def index_title(_page)
            TeX::TextSize.new('Index').huge
          end

          def notes_title(page)
            TeX::TextSize.new("Note #{page}").huge
          end
        end
      end
    end
  end
end
