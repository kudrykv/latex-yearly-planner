# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class Fonter
      DEFAULT_FONTS = {
        roman: nil,
        sans_serif: nil,
        monospace: nil
      }.freeze

      attr_reader :fonts

      def initialize(**parameters)
        @fonts = RecursiveOpenStruct.new(DEFAULT_FONTS.merge(parameters.compact))
      end

      def roman
        fonts.roman
      end

      def sans_serif
        fonts.sans_serif
      end

      def monospace
        fonts.monospace
      end
    end
  end
end
