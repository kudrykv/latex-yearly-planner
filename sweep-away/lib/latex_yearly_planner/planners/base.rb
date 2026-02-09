# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    class Base
      attr_reader :section_config, :i18n

      def initialize(section_config:, i18n: I18n)
        @section_config = section_config
        @i18n = i18n
      end

      def params
        section_config.params
      end
    end
  end
end
