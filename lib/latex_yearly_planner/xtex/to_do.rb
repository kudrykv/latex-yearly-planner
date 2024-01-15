# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class ToDo
      def default_parameters
        {
          count: 1,
          line_height: '5mm'
        }
      end

      attr_accessor :enabled, :parameters

      def initialize(**options)
        @enabled = options.fetch(:enabled, true)
        @parameters = RecursiveOpenStruct.new(default_parameters.deep_merge(options.fetch(:parameters, {}).compact))
      end

      def to_s
        "\\adjustbox{valign=t}{\\parbox{\\linewidth}{#{todos}}}"
      end

      private

      def todos
        ([todo] * parameters.count).join("\n")
      end

      def todo
        "#{MinHeight.new("\\dimexpr#{parameters.line_height}-.4pt")}$\\square$#{Line.gray}"
      end
    end
  end
end
