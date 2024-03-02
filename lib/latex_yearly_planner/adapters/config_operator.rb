# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class ConfigOperator
      attr_reader :section_config, :planner_config

      def initialize(section_config:)
        @section_config = section_config.section_config
        @planner_config = section_config.planner_config
      end

      def get(*keys)
        section_config.dig(:parameters, *keys)
      end
    end
  end
end
