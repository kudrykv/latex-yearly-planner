# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class Multicolumn
      attr_accessor :width, :format, :content

      def initialize(content: '', width: :full_width, format: 'c')
        @width = width
        @format = format
        @content = content
      end

      def to_s
        "\\multicolumn{#{width}}{#{format}}{#{content}}"
      end
    end
  end
end
