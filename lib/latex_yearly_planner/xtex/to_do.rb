# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class ToDo
      attr_accessor :count, :line_height, :show_label

      def initialize(**options)
        @count = options.fetch(:count, 1)
        @line_height = options.fetch(:line_height, '5mm')
        @show_label = options.fetch(:show_label, false)
      end

      def to_s
        "\\adjustbox{valign=t}{\\parbox{\\linewidth}{#{make_label}#{todos}}}"
      end

      private

      def make_label
        return '' unless show_label

        "#{MinHeight.new("\\dimexpr#{line_height}-.4pt")}To do:#{Line.plain}"
      end

      def todos
        ([todo] * count).join("\n")
      end

      def todo
        "#{MinHeight.new("\\dimexpr#{line_height}-.4pt")}$\\square$#{Line.gray}"
      end
    end
  end
end
