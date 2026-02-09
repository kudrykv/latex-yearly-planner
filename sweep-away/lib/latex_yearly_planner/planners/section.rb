# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    class Section < Base
      attr_reader :name, :page_constant

      def initialize(name:, page_constant:, section_config:, i18n: I18n)
        super(section_config:, i18n:)

        @name = name
        @page_constant = page_constant
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
        pages.map(&method(:generate_page)).join(pages_glue)
      end

      def generate_page(...)
        page_constant.new(section_config:, i18n:).set(...).generate
      end

      def pages_glue
        "#pagebreak()\n"
      end
    end
  end
end
