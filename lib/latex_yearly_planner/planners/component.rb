# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    class Component < Base
      def initialize(name:, section_config:)
        super()

        @name = name
        @section_config = section_config
      end
    end
  end
end
