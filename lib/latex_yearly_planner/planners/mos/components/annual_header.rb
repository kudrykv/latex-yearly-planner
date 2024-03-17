# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Components
        class AnnualHeader < Component
          def generate(...)
            params.placement(:side_navigation)

            <<~LATEX
              \\marginnote{%
                #{quarters_navigation}
                \\vskip#{params.get(:quarters_months_separation)}
                #{months_navigation}%
              }hello, world!
              \\vskip#{params.get(:header_separation)}
            LATEX
              .strip
          end

          private

          def in_margin_note
            params.placement(:side_navigation).map do |placement|
              next "\\vskip{#{placement}}" if placement.match?(/\A\d/)

              method(placement).call
            end.join("\n")
          end

          def quarters_navigation
            XTeX::VerticalStick.new(items: quarter_names, **quarter_navigation_params)
          end

          def quarter_names
            params.quarters.map do |quarter|
              "#{i18n.t('calendar.one_letter.quarter')}#{quarter.number}"
            end
          end

          def quarter_navigation_params
            params.object(:quarters_navigation).to_h
          end

          def months_navigation
            XTeX::VerticalStick.new(items: month_names, **month_navigation_params)
          end

          def month_names
            params.months.map do |month|
              i18n.t("calendar.short.month.#{month.name.downcase}")
            end
          end

          def month_navigation_params
            params.object(:months_navigation).to_h
          end
        end
      end
    end
  end
end
