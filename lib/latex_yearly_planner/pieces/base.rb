# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    class Base
      include TeX::Helpers

      attr_reader :config, :section_config, :section_name

      def initialize(section_name, config, section_config)
        @section_name = section_name
        @config = config
        @section_config = section_config
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
                   .map { |days| days.map { |day| Calendar::Day.new(day, weekday_start:) } }
                   .map { |days| Calendar::Week.new(days, weekday_start:) }
      end

      def all_days
        start_month.upto(end_month.end_of_month).map { |day| Calendar::Day.new(day, weekday_start:) }
      end

      def make_months_range(from_month, to_month)
        (from_month..to_month)
          .select { |date| date.mday == 1 }
          .map { |date| Calendar::Month.new(date, weekday_start:) }
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

      def parameters(*keys)
        param(*keys, :parameters_as_a_hash)
      end

      def struct(*keys)
        @struct ||= {}

        last = "#{keys.last}_as_a_hash".to_sym
        keys = keys.take(keys.size - 1).push(last)

        @struct[keys] ||= reduce_param(*keys)
      end

      def param(*keys)
        @param ||= {}

        @param[keys] ||= reduce_param(*keys)
      end

      def reduce_param(*keys)
        reduced = reduce_configs_with_keys(*keys)

        return reduced[1].compact.deep_merge(reduced[0].compact) if reduced[0].is_a?(Hash) && reduced[1].is_a?(Hash)

        one = reduced.compact.first
        one.is_a?(Hash) ? one.compact : one
      end

      def reduce_configs_with_keys(*keys)
        accumulator = [section_config&.parameters, config.parameters&.parameters]

        keys.reduce(accumulator) { |acc, key| [acc[0]&.send(key), acc[1]&.send(key)] }
      end
    end
  end
end
