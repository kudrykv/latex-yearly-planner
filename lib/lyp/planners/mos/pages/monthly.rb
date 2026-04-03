# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Pages
        class Monthly
          WEEK_PLACEMENTS = %i[left right none].freeze

          attr_accessor :i18n, :manifest, :month, :title_size, :week_placement, :month_params

          def initialize(i18n:, manifest:, month:, title_size:, month_params:)
            self.i18n = i18n
            self.manifest = manifest
            self.month = month
            self.title_size = title_size
            self.month_params = month_params
            self.week_placement = month_params[:week_placement].to_sym

            return if WEEK_PLACEMENTS.include?(week_placement)

            raise ConfigError, "week_placement: allowed: #{WEEK_PLACEMENTS}"
          end

          def title
            "text(size: #{title_size})[#{i18n.t("months.full.#{month.name}")}<#{month.id}>]"
          end

          def content
            <<~TYPST.strip
              grid(
                columns: 1fr,
                rows: (auto, 1fr),

                grid(
                  stroke: regular_stroke,
                  columns: (#{columns}),
                  rows: (#{rows}),

                  #{heading},
                  #{day_cells}
                ),

                grid(
                  columns: (1fr),
                  rows: (2mm, auto, 1fr),

                  [],
                  grid.cell(
                    stroke: (bottom: thick_stroke),
                    box(height: regular_height, align(horizon, [#{i18n.t("monthly_notes")}]))
                  ),
                  rect_pattern(dotted)
                )
              )
            TYPST
          end

          private

          def columns
            cols = ["1fr"] * 7

            with_week_column(cols, month_params[:week_label_width]).join(", ")
          end

          def rows
            head = [month_params[:heading_height]]
            body = [month_params[:daily_cell_height]] * month_in_weeks.count

            (head + body).join(", ")
          end

          def heading
            h = month_in_weeks.second.map do |day|
              "align(center + horizon)[#{i18n.t("weekday.full.#{day.weekday_name}")}]"
            end

            with_week_column(h, "[]").join(", ")
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
            text = "padded_link(<#{day.id}>)[#{text}]" if manifest.source? day.id

            "box(stroke: regular_stroke, inset: 3pt)[##{text}]"
          end

          def week_label_cell(week)
            current_week = first_present_day(week).week
            label = "#{i18n.t("week_name_full")} #{current_week.number}"
            label = "padded_link(<#{current_week.id}>)[#{label}]" if manifest.source? current_week.id

            "align(center + horizon, rotate(#{month_params[:week_label_rotation]}, reflow: true)[##{label}])"
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
