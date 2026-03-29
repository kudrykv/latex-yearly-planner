# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Components
        class LittleCalendar
          attr_reader :i18n, :manifest, :week_placement, :month, :show_month_name

          # rubocop:disable Lint/UnusedMethodArgument
          def initialize(i18n:, manifest:, week_placement:, month:, day: nil, show_month_name: true, **_rest)
            @i18n = i18n
            @manifest = manifest
            @week_placement = week_placement.to_sym
            @month = month
            @show_month_name = show_month_name
          end
          # rubocop:enable Lint/UnusedMethodArgument

          def generate
            <<~TYPST.strip
              grid(
                align: center + horizon,
                inset: 5pt,
                stroke: #{stroke},
                columns: (#{columns}),

                #{optional_month_name}
                #{heading}, grid.hline(stroke: regular_stroke),
                #{day_cells}
              )
            TYPST
          end

          private

          def stroke
            return "none" unless %i[left right].include?(week_placement)

            x = "1"
            x = "7" if week_placement == :right

            "(x, _) => if x == #{x} {( left: regular_stroke )}"
          end

          def columns
            cols = ["1fr"] * 7

            with_week_column(cols, "1fr").join(", ")
          end

          def optional_month_name
            return "" unless show_month_name

            <<~TYPST.strip
              grid.cell(
                colspan: #{with_week_column([""]*7, "").size},
                [#{i18n.t("months.full.#{month.name}")}]
              ),
              grid.hline(stroke: regular_stroke),
            TYPST
          end

          def heading
            h = month_in_weeks.second.map do |day|
              "[#{i18n.t("weekday.one_letter.#{day.weekday_name}")}]"
            end

            with_week_column(h, "[#{i18n.t("weekday.one_letter.week")}]").join(", ")
          end

          def day_cells
            month_in_weeks.map do |week|
              row = week.map { |day| day_cell(day) }

              with_week_column(row, week_label_cell(week)).join(", ")
            end.join(",\n")
          end

          def day_cell(day)
            return "[]" unless day

            text = day.month_day.to_s
            text = "padded_link(<#{day.id}>, padding: 6pt)[#{text}]" if manifest.source? day.id

            text
          end

          def week_label_cell(week)
            current_week = first_present_day(week).week
            label = current_week.number
            label = "padded_link(<#{current_week.id}>)[#{label}]" if manifest.source? current_week.id

            label
          end

          def first_present_day(week)
            week.compact.first
          end

          def with_week_column(cells, value)
            cells.prepend(value) if week_placement == :left
            cells.append(value) if week_placement == :right

            cells
          end

          def month_in_weeks
            @month_in_weeks ||= begin
              ranges = expand_week_ranges
              weeks = mask_outside_days(ranges)

              weeks.reject { |week| week.all?(&:nil?) }
            end
          end

          def expand_week_ranges
            first_week = month.day.beginning_of_week..month.day.end_of_week
            ranges = [first_week]

            while ranges.last.last.month == month
              prev_end = ranges.last.last
              ranges << ((prev_end + 1)..(prev_end + 7))
            end

            ranges
          end

          def mask_outside_days(ranges)
            ranges.map do |week|
              week.map { |day| day.month == month ? day : nil }
            end
          end
        end
      end
    end
  end
end
