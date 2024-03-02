# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class Dummy
      attr_reader :color, :text

      def initialize(color: 'white', text: 'Q')
        @color = color
        @text = text
      end

      def to_s
        "\\vphantom{#{text}}"
      end
    end
  end
end
