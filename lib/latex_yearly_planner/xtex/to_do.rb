# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class ToDo
      attr_accessor :count

      def initialize(count:)
        @count = count
      end

      def to_s
        "\\adjustbox{valign=t}{\\parbox{\\linewidth}{#{([todo] * count).join("\n")}}}"
      end

      private

      def todo
        "#{MinHeight.new('\\dimexpr5mm-.4pt')}$\\square$\\myLineGray"
      end
    end
  end
end
