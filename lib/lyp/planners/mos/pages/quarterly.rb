# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Pages
        class Quarterly
          attr_accessor :i18n, :manifest, :quarter

          def initialize(i18n:, manifest:, quarter:)
            self.i18n = i18n
            self.manifest = manifest
            self.quarter = quarter
          end

          def title
            "[#{i18n.t("quarters.long")} #{quarter.number}]"
          end

          def content
            <<~TYPST.strip
              grid(
                columns: (2fr, 3fr),

                #{months_stack}, rect_pattern(dotted)
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
              Components::LittleCalendar.new(i18n:, manifest:, week_placement: :left, month:).generate
            end
          end
        end
      end
    end
  end
end
