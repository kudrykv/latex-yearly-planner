# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class TextSize
      attr_reader :text

      def initialize(text)
        @text = text
      end

      def huge
        self.size = 'huge'

        self
      end

      def large
        self.size = 'large'

        self
      end

      def to_s
        return text unless size

        "{\\#{size}{}#{text}}"
      end

      private

      attr_accessor :size
    end
  end
end
