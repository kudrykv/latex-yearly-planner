# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class HyperTarget
      attr_accessor :content
      attr_writer :ref

      def initialize(content, ref: nil)
        @ref = ref
        @content = content
      end

      def ref
        @ref || content
      end

      def to_s
        "\\hypertarget{#{ref}}{#{content}}"
      end
    end
  end
end
