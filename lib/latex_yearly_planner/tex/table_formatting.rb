# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class TableFormatting

      attr_accessor :formatting

      def initialize(formatting)
        @formatting = formatting
      end

      def to_s
        formatting
      end
    end
  end
end
