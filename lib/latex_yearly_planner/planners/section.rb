# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    class Section
      attr_reader :name, :header, :body, :section_config, :planner_config

      def initialize(name:, header:, body:, section_config:, planner_config:)
        @name = name
        @header = header
        @body = body
        @section_config = section_config
        @planner_config = planner_config
      end
    end
  end
end
