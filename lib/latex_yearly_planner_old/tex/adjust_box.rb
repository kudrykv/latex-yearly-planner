# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class AdjustBox
      attr_accessor :content, :valign

      def initialize(content: '', valign: 't')
        @content = content

        @valign = valign
      end

      def to_s
        "\\adjustbox{valign=#{valign}}{#{content}}"
      end
    end
  end
end
