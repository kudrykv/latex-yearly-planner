# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    class Section
      include XTeX::Handy

      attr_reader :name, :header, :body, :section_config

      def initialize(name:, header:, body:, section_config:)
        @name = name
        @header = header
        @body = body
        @section_config = section_config
      end

      def generate
        pages.map(&method(:generate_page)).join(pages_glue)
      end

      private

      def generate_page(...)
        "#{header.generate(...)}#{body.generate(...)}"
      end

      def pages
        raise NotImplementedError
      end

      def pages_glue
        [nl, page_break, nlnl].join
      end
    end
  end
end
