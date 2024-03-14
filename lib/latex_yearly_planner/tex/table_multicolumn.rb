# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class TableMulticolumn
      attr_accessor :width, :format, :content

      def initialize(content, width, format: 'c')
        @content = content
        @width = width
        @format = format
      end

      def to_s
        "\\multicolumn{#{width}}{#{format}}{#{content}}"
      end
    end
  end
end
