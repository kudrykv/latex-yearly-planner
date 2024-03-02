# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class ConfigOperator
      attr_reader :section_config, :planner_config

      def initialize(section_config:)
        @section_config = section_config.section_config
        @planner_config = section_config.planner_config
      end
    end
  end
end
