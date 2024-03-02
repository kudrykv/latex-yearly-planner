# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    class Component < Base
      def initialize(name:, section_config:)
        super(section_config:)

        @name = name
      end
    end
  end
end
