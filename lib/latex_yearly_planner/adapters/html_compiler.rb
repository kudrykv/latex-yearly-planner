# frozen_string_literal: true

require 'English'

module LatexYearlyPlanner
  module Adapters
    class HtmlCompiler
      attr_reader :workdir, :planner_config

      def initialize(workdir:, planner_config:)
        @workdir = workdir
        @planner_config = planner_config
      end

      def compile(text_document)
        pdf = WickedPdf.new.pdf_from_string(
          File.read("#{workdir}/#{text_document.name}"),
          page_width: '138mm',
          page_height: '188mm',
          outline: {outline: false},
          margin: {top: 0, bottom: 0, left: 0, right: 0},
          dpi: 300,
          zoom: 1.248
        )

        File.open('./index.pdf', 'wb') { |file| file << pdf }
      end
    end
  end
end
