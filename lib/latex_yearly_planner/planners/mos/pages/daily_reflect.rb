# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Pages
        class DailyReflect < Face
          attr_reader :day

          def set(day)
            @day = day

            self
          end

          def title
            <<~TYPST
              [#grid(
                columns: 2,
                rows: (1fr, 1fr),
                inset: 0mm,
                align: left,
                grid.cell(
                  rowspan: 2,
                  stroke: (right: 0.4pt),
                  pad(right: 2mm, link(<#{day.id}>, text(#{params.get(:heading_size)})[#{day.day}]))
                ),
                pad(
                  left: 2mm,
                  bottom: 1mm,
                  [*#{i18n.t("calendar.weekdays.full.#{day.name.downcase}")}*]
                ),
                pad(left: 2mm, top: 1mm, [#{i18n.t("calendar.month.#{day.month.name.downcase}")}])
              )<dr-#{day.id}>]
            TYPST
          end

          def content
            <<~TYPST
              grid(
                columns: (#{params.get(:left_column_width)}, #{params.get(:gap_width)}, 1fr),
                rows: (auto, 1fr),
                #{column(:left_column_items)},
                [],
                #{column(:right_column_items)},

                grid.cell(colspan: 3, #{column(:bottom_merged)})
              )
            TYPST
          end

          def extra_menu_items
            return [] unless params.section_enabled?(:weekly)

            ["link(<#{day.week.id}>, [#{i18n.t('calendar.weekdays.full.week')} #{day.week.number}])"]
          end

          private

          def column(column_items)
            "stack(dir: ttb, #{run_methods_of(column_items)})"
          end

          def run_methods_of(column_items)
            params.get(column_items).map(&method(:send)).join(",\n")
          end

          def my_goals
            "jot(#{params.get(:pattern)}, #{params.get(:my_goals, :height)}, [#{i18n.t('daily_reflect.goals')}])"
          end

          def my_best_thing
            "jot(#{params.get(:pattern)}, #{params.get(:my_best_thing,
                                                       :height)}, [#{i18n.t('daily_reflect.best_thing')}])"
          end

          def my_grateful
            "jot(#{params.get(:pattern)}, #{params.get(:my_grateful, :height)}, [#{i18n.t('daily_reflect.grateful')}])"
          end

          def my_daily_log
            "jot(#{params.get(:pattern)}, #{params.get(:my_daily_log, :height)}, [#{i18n.t('daily_reflect.log')}])"
          end
        end
      end
    end
  end
end