# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class Annual
          attr_reader :section_name

          def initialize(section_name:, i18n:, configurator:, column_gutter: "10pt", row_gutter: "5pt", **other)
            self.section_name = section_name
            self.i18n = i18n
            self.configurator = configurator
            self.little_calendar = (configurator.dig(:planner, :params, :little_calendar) || {})
                                   .merge(other[:little_calendar] || {})
            self.column_gutter = column_gutter
            self.row_gutter = row_gutter
          end

          def register(manifest)
            manifest.register_source("calendar")
          end

          def pages(manifest)
            [PageData.new(
              title: "[Calendar<calendar>]",
              content: content(manifest:)
            )]
          end

          private

          attr_writer :section_name
          attr_accessor :i18n, :configurator, :little_calendar, :column_gutter, :row_gutter

          def content(manifest:)
            items = range.map do |month|
              Components::LittleCalendar.new(i18n:, manifest:, month:, **little_calendar).generate
            end

            <<~TYPST.strip
              grid(
                columns: (1fr, 1fr, 1fr),
                rows: 1fr,
                column-gutter: #{column_gutter},
                row-gutter: #{row_gutter},

                #{items.join(",\n")}
              )
            TYPST
          end

          def range
            configurator.start_date.month..configurator.end_date.month
          end
        end
      end
    end
  end
end
