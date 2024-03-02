# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class SectionConfig
      attr_reader :name, :config, :planner_config

      def initialize(name:, config:, planner_config:)
        @name = name
        @config = config
        @planner_config = planner_config
      end

      def enabled?
        config.enabled
      end

      def constant
        "LatexYearlyPlanner::Planners::#{template.camelize}::Sections::#{name.to_s.camelize}".constantize
      end

      private

      def template
        planner_config.template
      end
    end
  end
end
