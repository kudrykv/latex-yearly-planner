# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class Annual
          def initialize(name:, i18n:, overseer:, little_calendar:, **_rest)
            self.name = name
            self.i18n = i18n
            self.overseer = overseer
            self.little_calendar = little_calendar
          end

          def registered_section_name = name

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

          attr_accessor :name, :i18n, :overseer, :little_calendar

          def content(manifest:)
            items = (overseer.start_date.month..overseer.end_date.month)
                    .map { |month| Components::LittleCalendar.new(i18n:, manifest:, month:, **little_calendar).generate }

            <<~TYPST.strip
              grid(
                columns: (1fr, 1fr, 1fr),
                rows: 1fr,
                inset: 5pt,

                #{items.join(",\n")}
              )
            TYPST
          end
        end
      end
    end
  end
end
