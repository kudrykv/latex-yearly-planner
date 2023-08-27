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

      def pagebreak
        '\pagebreak{}'
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
    end
  end
end
