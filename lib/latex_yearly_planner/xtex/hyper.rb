# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class Hyper
      KEYS = %i[page year].freeze

      attr_accessor :content
      attr_reader :refs

      def initialize(content, **refs)
        @content = content
        @refs = refs.slice(KEYS)

        raise ArgumentError, "Invalid keys: #{refs.keys - KEYS}" if @refs.size < refs.size
      end

      def link
        TeX::HyperLink.new(content, ref:)
      end

      private

      def ref
        return nil if refs.empty?

        KEYS.map { |key| refs[key] }.compact.join('-')
      end
    end
  end
end
