# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class Line
      def self.plain(**options)
        new(**options)
      end

      def self.gray(**options)
        new(**options.merge(color: 'gray'))
      end

      def self.light_gray(**options)
        new(**options.merge(color: 'gray!50'))
      end

      attr_accessor :thickness, :color

      def initialize(**options)
        @thickness = options.fetch(:thickness, '.4pt')
        @color = options.fetch(:color, nil)
      end

      def to_s
        return line if color.nil?

        "\\textcolor{#{color}}{#{line}}"
      end

      private

      def line
        "\\hrule width \\linewidth height #{thickness}"
      end
    end
  end
end
