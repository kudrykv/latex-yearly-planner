# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
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

          def labels
            "#hide[~#{week.ids.map { |id| "#label(\"#{id}\")" }.join(' ~')}]"
          end

          def content
            first_name_height = params.get(:first_row_height)
            name_height = params.get(:rest_row_height)

            <<~TYPST
              grid(
                columns: (1fr, 1fr),
                rows: (#{first_name_height}, 1fr, #{name_height}, 1fr, #{name_height}, 1fr, #{name_height}, 1fr),
                align(horizon, #{format_day(week.days[0])}), align(horizon, #{format_day(week.days[1])}),
                grid.cell(colspan: 2, rect_pattern(#{params.get(:pattern)})),
                align(horizon, #{format_day(week.days[2])}), align(horizon, #{format_day(week.days[3])}),
                grid.cell(colspan: 2, rect_pattern(#{params.get(:pattern)})),
                align(horizon, #{format_day(week.days[4])}), align(horizon, #{format_day(week.days[5])}),
                grid.cell(colspan: 2, rect_pattern(#{params.get(:pattern)})),
                align(horizon, #{format_day(week.days[6])}), [],
                grid.cell(colspan: 2, rect_pattern(#{params.get(:pattern)})),
              )
            TYPST
          end

          def top_menu_month
            side_menu_months.first
          end

          def side_menu_months
            week.months.select { |month| params.months.include? month }
          end

          def side_menu_quarters
            side_menu_months.map(&:quarter).uniq
          end

          private

          def format_day(day)
            dayname = day.strftime('%A')
            daynum = day.strftime('%-d')

            first_day = params.months.first.moment.beginning_of_month
            last_day = params.months.last.moment.end_of_month

            if day.moment < first_day || day.moment > last_day
              return "[#{i18n.t("calendar.weekdays.full.#{dayname.downcase}")}, #{daynum}]"
            end

            <<~TYPST
              link(<#{day.id}>, [#{i18n.t("calendar.weekdays.full.#{dayname.downcase}")}, #{daynum}])
            TYPST
          end
        end
      end
    end
  end
end
