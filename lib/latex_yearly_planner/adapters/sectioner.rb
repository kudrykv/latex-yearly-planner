# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class Sectioner
      attr_reader :planner_config

      def sections
        planner_config.sections
      end
    end
  end
end
