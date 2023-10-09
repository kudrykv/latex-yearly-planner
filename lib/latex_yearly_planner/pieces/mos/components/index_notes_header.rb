# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class IndexNotesHeader < Header
          def generate_index(page)
            make_header(top_table(page:), index_title(page))
          end

          def generate_notes(note, page)
            make_header(top_table(page:, note:), notes_title(note))
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
