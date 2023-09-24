# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class IndexNotesHeader < Header
          def generate_index(page)
            [
              top_table(page:),
              hfill,
              index_title(page),
              hrule,
              margin_note,
              nl,
              vspace(param(:header, :skip)),
              nlnl
            ].join
          end

          def generate_notes(note, page)
            [
              top_table(page:, note:),
              hfill,
              notes_title(page, note),
              hrule,
              margin_note,
              nl,
              vspace(param(:header, :skip)),
              nlnl
            ].join
          end

          private

          def index_title(page)
            target_reference(TeX::TextSize.new('Index').huge, reference: 'notes', page:)
          end

          def notes_title(page, note)
            link_reference(TeX::TextSize.new("Note #{note}").huge, reference: 'notes', page:)
          end
        end
      end
    end
  end
end
