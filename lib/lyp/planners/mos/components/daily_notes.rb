# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Components
        class DailyNotes
          attr_accessor :i18n, :manifest, :day, :title_height, :notes_height

          def initialize(i18n:, manifest:, day:, title_height:, notes_height:, **_rest)
            self.i18n = i18n
            self.manifest = manifest
            self.day = day
            self.title_height = title_height
            self.notes_height = notes_height
          end

          def generate
            daily_note_id = Entities::DatedNote.new(weekday_start: day.weekday_start, day:).id
            if manifest.source? daily_note_id
              more = " #padded_link(<#{daily_note_id}>)[| #{i18n.t("more_daily_notes")}]"
            end

            <<~TYPST.strip
              grid(
                columns: 1fr,
                rows: (#{title_height}, #{notes_height}),
                grid.cell(align:horizon, stroke: (bottom: thick_stroke), [#{i18n.t("daily_notes")}#{more}]),
                scratch_pad
              )
            TYPST
          end
        end
      end
    end
  end
end
