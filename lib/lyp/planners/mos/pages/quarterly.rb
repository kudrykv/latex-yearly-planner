# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Pages
        class Quarterly
          attr_accessor :i18n, :manifest, :quarter, :months_column, :little_calendar

          def initialize(i18n:, manifest:, quarter:, months_column:, little_calendar:)
            self.i18n = i18n
            self.manifest = manifest
            self.quarter = quarter
            self.months_column = months_column
            self.little_calendar = little_calendar
          end

          def title
            "text(size: h1)[#{i18n.t("quarters.long")} #{quarter.number} <#{quarter.id}>]"
          end

          def content
            cols = %w[2fr 3fr]
            columns = [months_stack, "rect_pattern(dotted)"]

            cols.reverse! if months_column == :right
            columns.reverse! if months_column == :right

            <<~TYPST.strip
              grid(
                columns: (#{cols.join(",")}),

                #{columns.join(", ")}
              )
            TYPST
          end

          private

          def months_stack
            <<~TYPST.strip
              stack(
                dir: ttb,
                spacing: 1fr,

                #{months.join(", ")}
              )
            TYPST
          end

          def months
            quarter.months.map do |month|
              Components::LittleCalendar.new(i18n:, manifest:, month:, **little_calendar).generate
            end
          end
        end
      end
    end
  end
end
