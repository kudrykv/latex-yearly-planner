# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class Parbox
      attr_reader :content, :width

      def initialize(content: '', width: '\\linewidth')
        @content = content
        @width = width
      end

      def to_s
        "\\parbox{#{width}}{#{content}}"
      end
    end
  end
end
