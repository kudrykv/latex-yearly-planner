# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Weekly < Face
          def title(week)
            "text(#{params.get(:heading_size)})[#{i18n.t('calendar.weekdays.full.week')} #{week.number} #{labels(week)}]"
          end

          def labels(week)
            "#hide[~#{week.ids.map { |id| "#label(\"#{id}\")" }.join(' ~')}]"
          end

          def content(week)
            first_name_height = params.get(:first_row_height)
            name_height = params.get(:rest_row_height)

            <<~TYPST
              grid(
                columns: (1fr, 1fr),
                rows: (#{first_name_height}, 1fr, #{name_height}, 1fr, #{name_height}, 1fr, #{name_height}, 1fr),
                align(horizon, [#{format_day(week.days[0])}]), align(horizon, [#{format_day(week.days[1])}]),
                grid.cell(colspan: 2, rect_pattern(#{params.get(:pattern)})),
                align(horizon, [#{format_day(week.days[2])}]), align(horizon, [#{format_day(week.days[3])}]),
                grid.cell(colspan: 2, rect_pattern(#{params.get(:pattern)})),
                align(horizon, [#{format_day(week.days[4])}]), align(horizon, [#{format_day(week.days[5])}]),
                grid.cell(colspan: 2, rect_pattern(#{params.get(:pattern)})),
                align(horizon, [#{format_day(week.days[6])}]), [],
                grid.cell(colspan: 2, rect_pattern(#{params.get(:pattern)})),
              )
            TYPST
          end

          def top_menu_month(week)
            side_menu_months(week).first
          end

          def side_menu_months(week)
            week.months.select { |month| params.months.include? month }
          end

          def side_menu_quarters(week)
            side_menu_months(week).map(&:quarter).uniq
          end

          private

          def format_day(moment)
            dayname = moment.strftime('%A')
            daynum = moment.strftime('%-d')

            <<~TYPST
              #{i18n.t("calendar.weekdays.full.#{dayname.downcase}")}, #{daynum}
            TYPST
          end
        end
      end
    end
  end
end
