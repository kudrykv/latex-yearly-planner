# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class Cell
      attr_reader :content

      def initialize(content)
        @content = content
        @selected = false
      end

      def selected
        @selected = true

        self
      end

      def to_s
        return content unless selected

        "\\cellcolor{black}{\\textcolor{white}{#{content}}}"
      end
    end
  end
end
