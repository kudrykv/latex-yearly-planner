# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    class Section < Base
      attr_reader :header, :body

      def initialize(section_name, config, section_config, header, body)
        super(section_name, config, section_config)

        @header = header
        @body = body
      end

      def enabled?
        section_config.enabled || false
      end

      def generate
        NotImplementedError
      end

      def all_months
        @all_months ||= make_months_range(start_month, end_month)
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
