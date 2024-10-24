# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class NotesPages < Face
          attr_reader :note_number

          def set(note_number)
            @note_number = note_number

            self
          end

          def title
            <<~TYPST
              text(#{params.get(:heading_size)})[#{i18n.t('notes.single_page')} #{note_number} <np-#{note_number}>]
            TYPST
          end

          def content
            "rect_pattern(#{params.get(:pattern)})"
          end
        end
      end
    end
  end
end
