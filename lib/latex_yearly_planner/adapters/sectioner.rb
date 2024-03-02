# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class Sectioner
      attr_reader :planner_config

      def initialize(planner_config:)
        @planner_config = planner_config
      end

      def sections
        planner_config.sections.select(&:enabled?).map(&method(:make_section))
      end

      private

      def make_section(section_config)
        section_config.constant
      end
    end
  end
end
