# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    class Base
      attr_reader :config, :section_config, :section_name

      def initialize(section_name, config, section_config)
        @section_name = section_name
        @config = config
        @section_config = section_config
      end

      def param(key)
        @param ||= {}

        @param[key] ||= section_config.parameters&.send(key) || config.parameters&.parameters&.send(key)
      end

      def all_months
        @all_months ||= make_months_range(start_month, end_month)
      end

      def all_quarters
        all_months.map(&:quarter).uniq(&:date)
      end

      def all_weeks
        start_month.beginning_of_week(weekday_start)
                   .upto(end_month.end_of_month.end_of_week(weekday_start))
                   .each_slice(7)
                   .map { |days| Calendar::Week.new(days) }
      end

      def make_months_range(from_month, to_month)
        (from_month..to_month).select { |date| date.mday == 1 }.map do |date|
          LatexYearlyPlanner::Calendar::Month.new(date, weekday_start:)
        end
      end

      def start_month
        @start_month ||= Date.parse(config.parameters.parameters.start_date)
      end

      def end_month
        @end_month ||= Date.parse(config.parameters.parameters.end_date)
      end

      def weekday_start
        @weekday_start ||= param(:weekday_start).downcase.to_sym
      end
    end
  end
end
