# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class ResizeBox
      DEFAULT_PARAMETERS = {
        width: '!',
        height: '!'
      }.freeze

      attr_reader :content, :parameters

      def initialize(content, **parameters)
        @content = content
        @parameters = RecursiveOpenStruct.new(DEFAULT_PARAMETERS.merge(parameters))
      end

      def to_s
        "\\resizebox{#{width}}{#{height}}{#{content}}"
      end

      private

      def width
        parameters.width
      end

      def height
        parameters.height
      end
    end
  end
end
