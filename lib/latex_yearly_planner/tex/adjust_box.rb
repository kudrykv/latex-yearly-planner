# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class AdjustBox
      attr_reader :content, :vertical_align

      def initialize(content, vertical_align: 't')
        @content = content
        @vertical_align = vertical_align
      end

      def to_s
        "\\adjustbox{valign=#{vertical_align}}{#{content}}"
      end
    end
  end
end
