# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
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
                  link(<#{day.id}>, [*#{i18n.t("calendar.weekdays.full.#{day.name.downcase}")}*,
                    #{i18n.t("calendar.month.#{day.month.name.downcase}")}])
                ),
                pad(left: 2mm, top: 1mm, link(<#{day.week.id}>, [#{i18n.t('calendar.weekdays.full.week')} #{day.week.number}])),
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
            "jot(#{params.get(:pattern)}, #{params.get(:my_best_thing, :height)}, [#{i18n.t('daily_reflect.best_thing')}])"
          end

          def my_grateful
            "jot(#{params.get(:pattern)}, #{params.get(:my_grateful, :height)}, [#{i18n.t('daily_reflect.grateful')}])"
          end

          def my_daily_log
            "jot(#{params.get(:pattern)}, #{params.get(:my_daily_log, :height)}, [#{i18n.t('daily_reflect.daily_log')}])"
          end
        end
      end
    end
  end
end
