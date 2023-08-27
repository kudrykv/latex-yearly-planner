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
        pages = pages_parameters.map { |parameters| "#{header.generate(*parameters)}#{body.generate(*parameters)}" }

        Core::Entities::Note.new(section_name, "#{pages.join("\n\\pagebreak{}\n\n")}\n\\pagebreak{}")
      end

      def pages_parameters
        raise NotImplementedError
      end
    end
  end
end
