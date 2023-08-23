# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class Config
      def initialize(hash)
        @struct = RecursiveOpenStruct.new(hash, recurse_over_arrays: true)
      end

      def respond_to_missing?(...)
        struct.respond_to?(...)
      end

      def method_missing(...)
        struct.method_missing(...)
      end

      def template
        return self unless struct.parameters.template_name

        "LatexYearlyPlanner::Pieces::#{struct.parameters.template_name.camelize}::Config".constantize.new(struct)
      end

      private

      attr_reader :struct
    end
  end
end
