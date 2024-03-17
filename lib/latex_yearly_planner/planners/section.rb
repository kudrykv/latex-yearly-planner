# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    class Section < Base
      attr_reader :name, :header, :body

      def initialize(name:, header:, body:, section_config:, i18n: I18n)
        super(section_config:, i18n:)

        @name = name
        @header = header
        @body = body
      end

      def enabled?
        section_config.enabled?
      end

      def generate
        Entities::TextDocument.new(name: "#{name}.tex", content:)
      end

      private

      def content
        pages.map(&method(:generate_page)).join(pages_glue)
      end

      def generate_page(...)
        "#{header.generate(...)}#{body.generate(...)}"
      end

      def pages
        raise NotImplementedError
      end

      def pages_glue
        [page_break, nlnl].join
      end
    end
  end
end
