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
          page_width: planner_config.config[:document][:layout][:dimensions][:width],
          page_height: planner_config.config[:document][:layout][:dimensions][:height],
          outline: {outline: false},
          margin: {top: 0, bottom: 0, left: 0, right: 0},
          dpi: planner_config.config[:wicked][:dpi],
          zoom: planner_config.config[:wicked][:zoom]
        )

        File.open('./index.pdf', 'wb') { |file| file << pdf }
      end
    end
  end
end
