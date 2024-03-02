# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    class Base
      include XTeX::Handy

      attr_reader :section_config

      def initialize(section_config:)
        @section_config = section_config
      end
    end
  end
end
