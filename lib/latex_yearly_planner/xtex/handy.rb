# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    module Handy
      def nl
        "\n"
      end

      def nlnl
        "\n\n"
      end

      def page_break
        '\pagebreak{}'
      end

      def horizontal_spring
        '\hfill{}'
      end

      def vertical_spring
        '\vfill{}'
      end
    end
  end
end
