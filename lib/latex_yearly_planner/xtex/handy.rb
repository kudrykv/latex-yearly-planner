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
    end
  end
end
