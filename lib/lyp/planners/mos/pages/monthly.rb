# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Pages
        class Monthly
          attr_accessor :i18n, :manifest, :month, :title_size, :week_placement, :month_params

          def initialize(i18n:, manifest:, month:, title_size:, month_params:)
            self.i18n = i18n
            self.manifest = manifest
            self.month = month
            self.title_size = title_size
            self.week_placement = month_params[:week_placement]
            self.month_params = month_params

            return if %w[left right none].include? month_params[:week_placement]

            raise ConfigError, "week_placement: allowed 'left', 'right', or 'none'"
          end

          def title = "text(size: #{title_size})[#{i18n.t("months.full.#{month.name}")}<#{month.id}>]"

          def content
            <<~TYPST.strip
              stack(
                dir: ttb,
                spacing: 0mm,

                grid(
                  stroke: 0.4pt,
                  columns: (#{columns}),
                  rows: (#{rows}),

                  #{heading},
                  #{day_cells}
                )
              )
            TYPST
          end

          private

          def columns
            cols = ["1fr"] * 7
            cols.prepend(month_params[:week_label_width]) if week_placement == "left"
            cols.append(month_params[:week_label_width]) if week_placement == "right"

            cols.join(", ")
          end

          def rows
            (["auto"] + ([month_params[:daily_cell_height]] * month_in_weeks.count)).join(", ")
          end

          def heading
            h = month_in_weeks.second.map do |day|
              "align(center)[#{i18n.t("weekday.full.#{day.weekday_name}")}]"
            end

            h.prepend("[]") if week_placement == "left"
            h.append("[]") if week_placement == "right"

            h.join(", ")
          end

          def day_cells
            month_in_weeks.map do |week|
              row = week.map do |day|
                next "[]" unless day

                "box(stroke: 0.4pt, inset: 3pt)[#{day.month_day}]"
              end

              current_week = (week.first || week.last).week
              week_label = "align(center + horizon, rotate(#{month_params[:week_label_rotation]}, reflow: true)[#{i18n.t("week_name_full")} #{current_week.number}])"
              week_label = "link(<#{current_week.id}>)[##{week_label}]" if manifest.source? current_week.id

              row.prepend(week_label) if week_placement == "left"
              row.append(week_label) if week_placement == "right"

              row.join(", ")
            end.join(",\n")
          end

          def month_in_weeks
            @month_in_weeks ||= begin
              weeks = [month.day.beginning_of_week..month.day.end_of_week]
              weeks << ((weeks.last.last + 1)..(weeks.last.last + 7)) while weeks.last.last.month == month

              weeks = weeks.map do |week|
                week.map do |day|
                  next nil if day.month != month

                  day
                end
              end

              weeks.reject { |week| week.all?(&:nil?) }
            end
          end
        end
      end
    end
  end
end
