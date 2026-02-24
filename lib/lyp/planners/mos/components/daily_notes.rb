# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Components
        class DailyNotes
          attr_accessor :i18n, :title_height, :notes_height, :pattern

          def initialize(i18n:, title_height:, notes_height:, pattern:, **_rest)
            self.i18n = i18n
            self.title_height = title_height
            self.notes_height = notes_height
            self.pattern = pattern
          end

          def generate
            <<~TYPST.strip
              grid(
                columns: 1fr,
                rows: (#{title_height}, #{notes_height}),
                grid.cell(align:horizon, stroke: (bottom: 1pt), [#{i18n.t("daily_notes")}]),
                rect_pattern(#{pattern})
              )
            TYPST
          end
        end
      end
    end
  end
end
