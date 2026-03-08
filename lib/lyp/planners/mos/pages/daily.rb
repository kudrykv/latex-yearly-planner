# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Pages
        class Daily
          attr_accessor :i18n, :manifest, :day, :columns_width, :column_gutter, :items_spacing, :params, :debug

          def initialize(i18n:, manifest:, day:, columns_width:, column_gutter:, items_spacing:, debug: false, **params)
            self.i18n = i18n
            self.manifest = manifest
            self.day = day
            self.columns_width = columns_width
            self.column_gutter = column_gutter
            self.items_spacing = items_spacing
            self.params = params
            self.debug = debug
          end

          def title
            week = "#{i18n.t("week_name_full")} #{day.week.number}"
            week = "link(<#{day.week.id}>)[#{week}]" if manifest.source?(day.week.id)

            <<~TYPST
              grid(
                columns: (auto, auto),
                rows: (3fr, 2fr),
                column-gutter: 4pt,
                #{"stroke: 0.4pt," if debug}

                grid.cell(
                  rowspan: 2,
                  align: center + horizon,
                  rect(
                    stroke: (right: 0.4pt),

                    text(size: 24pt)[#{day.month_day} <#{day.id}>]
                  )
                ),
                [*#{i18n.t("weekday.full.#{day.weekday_name}")}*],
                #{week}
              )
            TYPST
          end

          def content
            <<~TYPST.strip
              grid(
                columns: #{columns_width},
                rows: 1fr,
                column-gutter: #{column_gutter},
                #{left_column},
                #{right_column}
              )
            TYPST
          end

          private

          def left_column
            column(params[:left_column])
          end

          def right_column
            column(params[:right_column])
          end

          def column(comps)
            list = comps.filter_map do |comp|
              next unless comp[:enabled]

              klass = components[comp[:class]]
              raise ConfigError, "unknown component: #{comp[:class]}" if klass.nil?

              klass.new(i18n:, manifest:, day:, **comp[:params]).generate
            end

            <<~TYPST.strip
              stack(
                dir: ttb,
                spacing: #{items_spacing},
                #{list.join(",\n")}
              )
            TYPST
          end

          def components
            @components ||= {
              "schedule" => Components::DailySchedule,
              "top_priorities" => Components::DailyTopPriorities,
              "notes" => Components::DailyNotes,
              "little_calendar" => Components::LittleCalendar,
            }.freeze
          end
        end
      end
    end
  end
end
