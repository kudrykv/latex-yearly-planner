# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    class Section < Base
      attr_reader :header, :body

      def initialize(section_name, config, section_config, header, body)
        super(section_name, config, section_config)

        @header = header
        @body = body
      end

      def enabled?
        section_config.enabled || false
      end

      def generate
        pages = iterations.map { |parameters| "#{header.generate(*parameters)}#{body.generate(*parameters)}" }

        Core::Entities::Note.new(section_name, "#{pages.join(pages_glue)}#{nl}#{page_break}")
      end

      def iterations
        raise NotImplementedError
      end

      def pages_glue
        [nl, page_break, nlnl].join
      end
    end
  end
end
