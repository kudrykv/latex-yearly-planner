# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class DailyNotes
          attr_reader :section_name

          def initialize(section_name:, i18n:, configurator:, pages:, **_rest)
            self.section_name = section_name
            self.i18n = i18n
            self.configurator = configurator
            self.pages_num = pages
          end

          def register(manifest)
            range.each do |daily_note|
              manifest.register_source daily_note.id
            end
          end

          def pages(manifest)
            range.map do |daily_note|
              PageData.new(
                title: title(manifest:, daily_note:),
                content: "scratch_pad",
                highlight_months: [daily_note.day.month],
                highlight_quarters: [daily_note.day.quarter]
              )
            end
          end

          private

          attr_writer :section_name
          attr_accessor :i18n, :configurator, :pages_num

          # rubocop:disable Metrics/AbcSize
          def title(manifest:, daily_note:)
            week = "#{i18n.t("week_name_full")} #{daily_note.day.week.number}"
            week = "padded_link(<#{daily_note.day.week.id}>)[#{week}]" if manifest.source?(daily_note.day.week.id)

            day = "text(size: h1)[#{daily_note.day.month_day} <#{daily_note.id}>]"
            day = "padded_link(<#{daily_note.day.id}>)[##{day}]" if manifest.source? daily_note.day.id

            <<~TYPST.strip
              grid(
                columns: (auto, auto),
                rows: (3fr, 2fr),
                column-gutter: 4pt,

                grid.cell(
                  rowspan: 2,
                  align: center + horizon,
                  rect(
                    stroke: (right: regular_stroke),

                    #{day}
                  )
                ),
                [*#{i18n.t("weekday.full.#{daily_note.day.weekday_name}")}*],
                #{week}
              )
            TYPST
          end
          # rubocop:enable Metrics/AbcSize

          def range
            (configurator.start_date..configurator.end_date).map do |day|
              (1..pages_num).map do |page_num|
                Entities::DatedNote.new(day:, weekday_start: day.weekday_start, page: page_num)
              end
            end.flatten
          end
        end
      end
    end
  end
end
