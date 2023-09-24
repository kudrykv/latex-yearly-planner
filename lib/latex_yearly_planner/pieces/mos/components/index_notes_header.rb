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
              notes_title(note),
              hrule,
              margin_note,
              nl,
              vspace(param(:header, :skip)),
              nlnl
            ].join
          end

          private

          def index_title(page)
            target_reference(TeX::TextSize.new('Index').huge, reference: NOTES_INDEX_REFERENCE, page:)
          end

          def notes_title(note)
            content = TeX::TextSize.new("Note #{note}").huge
            target_note(content, note:)
          end
        end
      end
    end
  end
end
