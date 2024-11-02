# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    class Page < Base
      def initialize(section_config:, i18n: I18n)
        super(section_config:, i18n:)
      end

      def set(...)
        raise NotImplementedError
      end
    end
  end
end
