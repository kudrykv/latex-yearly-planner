# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    module Helpers
      def nl
        "\n"
      end

      def nlnl
        "\n\n"
      end

      def page_break
        '\pagebreak{}'
      end

      def fill
        Fill.new
      end

      def hfill
        HFill.new.to_s
      end

      def vfill
        VFill.new.to_s
      end

      def hrule
        HRule.new.to_s
      end

      def vspace(height)
        VSpace.new(height).to_s
      end

      def hspace(width)
        HSpace.new(width).to_s
      end

      def target(content, ref: nil)
        HyperTarget.new(content, ref:).to_s
      end

      def huge(content)
        TextSize.new(content).huge.to_s
      end

      def large(content)
        TextSize.new(content).large.to_s
      end
    end
  end
end
