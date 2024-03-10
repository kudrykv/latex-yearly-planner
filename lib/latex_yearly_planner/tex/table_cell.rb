# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class TableCell
      attr_accessor :content

      def initialize(content)
        @content = content
      end

      def to_s
        content.to_s
      end
    end
  end
end
