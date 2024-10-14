# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    class Section < Base
      attr_reader :name, :page

      def initialize(name:, page:, section_config:, i18n: I18n)
        super(section_config:, i18n:)

        @name = name
        @page = page
      end

      def enabled?
        section_config.enabled?
      end

      def generate
        Entities::TextDocument.new(name:, content:)
      end

      def pages
        raise NotImplementedError
      end

      private

      def content
        pages.each.with_index(1).map(&method(:generate_page)).join(pages_glue)
      end

      def generate_page(...)
        page.generate(...)
      end

      def pages_glue
        "#pagebreak()\n"
      end
    end
  end
end
