# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Pages
        class Weekly < Face
          attr_reader :week

          def set(week)
            @week = week

            self
          end

          def title
            "text(#{params.get(:heading_size)})[#{i18n.t('calendar.weekdays.full.week')} #{week.number} #{labels}]"
          end

          def content
            first_name_height = params.get(:first_row_height)
            name_height = params.get(:rest_row_height)

            <<~TYPST
              grid(
                columns: (1fr, 1fr),
                rows: (#{first_name_height}, 1fr, #{name_height}, 1fr, #{name_height}, 1fr, #{name_height}, 1fr),
                #{weekly_grid}
              )
            TYPST
          end

          def top_menu_month
            highlight_side_menu_months.first
          end

          def highlight_side_menu_months
            @highlight_side_menu_months ||= week.months.select { |month| params.months.include? month }
          end

          def highlight_side_menu_quarters
            highlight_side_menu_months.map(&:quarter).uniq
          end

          private

          def labels
            "#hide[~#{week.ids.map { |id| "<#{id}>" }.join(' ~')}]"
          end

          def weekly_grid
            week.days.map(&method(:format_day)).map(&method(:align_day)).push('[]')
                .each_slice(2).map { |slice| slice.join(', ') }
                .join(",\n#{jotting_space},\n") + ",\n#{jotting_space}"
          end

          def jotting_space
            @jotting_space ||= "grid.cell(colspan: 2, rect_pattern(#{params.get(:pattern)}))"
          end

          def format_day(day)
            first_day = params.months.first.first_day
            last_day = params.months.last.last_day

            return day_label(day) if day < first_day || day > last_day

            "link(<#{day.id}>, #{day_label(day)})"
          end

          def day_label(day)
            dayname = day.strftime('%A')
            daynum = day.strftime('%-d')

            "[#{i18n.t("calendar.weekdays.full.#{dayname.downcase}")}, #{daynum}]"
          end

          def align_day(day)
            "align(horizon, #{day})"
          end
        end
      end
    end
  end
end
