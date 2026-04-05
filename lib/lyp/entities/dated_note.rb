# frozen_string_literal: true

module LYP
  module Entities
    class DatedNote
      include Comparable

      attr_reader :weekday_start, :day, :page

      def initialize(weekday_start:, day:, page: 1)
        self.weekday_start = weekday_start
        self.day = day
        self.page = page
      end

      def id = "daily-note-#{day.strftime("%Y-%m-%d")}-page-#{page}"

      private

      attr_writer :weekday_start, :day, :page

      def hash = [weekday_start, day].hash

      def eql?(other)
        return false unless other.is_a? Day

        weekday_start.eql?(other.weekday_start) && day.eql?(other.day)
      end
    end
  end
end
