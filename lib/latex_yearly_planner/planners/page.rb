# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    class Page < Base
      def initialize(name:, section_config:, i18n: I18n)
        super(section_config:, i18n:)

        @name = name
      end
    end
  end
end
