# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    class Component
      def initialize(name:, section_config:, planner_config:)
        @name = name
        @section_config = section_config
        @planner_config = planner_config
      end
    end
  end
end
