# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class Cell
      attr_reader :content
      attr_accessor :selected

      def initialize(content, selected: false)
        @content = content
        @selected = selected
      end

      def to_s
        return content unless selected

        "\\cellcolor{black}{\\textcolor{white}{#{content}}}"
      end
    end
  end
end
