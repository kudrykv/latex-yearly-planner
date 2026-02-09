# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class ConfigOperator
      attr_reader :section_config, :planner_config

      def initialize(section_config:)
        @section_config = section_config
        @planner_config = section_config.planner_config
      end

      def get(*keys)
        section_config.section_config.dig(:parameters, *keys) ||
          planner_config.planner.dig(:parameters, *keys)
      end

      def object(key)
        (planner_config.config.dig(:planner, :objects, key) || {})
          .merge(section_config.section_config.dig(:objects, key) || {})
      end

      def months
        (start_date..end_date)
          .select { |date| date.mday == 1 }
          .map(&method(:initialize_month))
      end

      def quarters
        months.each_slice(3).map(&:first).map(&:quarter)
      end

      def weeks
        @weeks ||= start_date.beginning_of_week(weekday_start)
                             .upto(end_date.end_of_month.end_of_week(weekday_start))
                             .each_slice(7)
                             .map { |days| days.map { |day| Calendar::Day.new(moment: day, weekday_start:) } }
                             .map { |days| Calendar::Week.new(days:, weekday_start:) }
      end

      def days
        @days ||= start_date.upto(end_date.end_of_month).map { |day| Calendar::Day.new(moment: day, weekday_start:) }
      end

      def section_enabled?(section_name)
        planner_config.sections.find { |s| s.name == section_name }&.enabled? || false
      end

      def section!(section_name)
        @section ||= planner_config.sections.find { |s| s.name == section_name }

        raise DevelopmentError, "Section #{section_name} not found" if @section.nil?

        @section
      end

      private

      def start_date
        @start_date ||= Date.parse(get(:start_date))
      end

      def end_date
        @end_date ||= Date.parse(get(:end_date))
      end

      def initialize_month(date)
        Calendar::Month.new(weekday_start:, year: date.year, month: date.month)
      end

      def weekday_start
        @weekday_start ||= get(:weekday_start).downcase.to_sym
      end
    end
  end
end
