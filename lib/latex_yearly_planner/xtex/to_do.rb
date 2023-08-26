# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class ToDo
      attr_accessor :count, :line_height

      def initialize(**options)
        @count = options.fetch(:count, 1)
        @line_height = options.fetch(:line_height, '5mm')
      end

      def to_s
        "\\adjustbox{valign=t}{\\parbox{\\linewidth}{#{todos}}}"
      end

      private

      def todos
        ([todo] * count).join("\n")
      end

      def todo
        "#{MinHeight.new("\\dimexpr#{line_height}-.4pt")}$\\square$#{Line.gray}"
      end
    end
  end
end
