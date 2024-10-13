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
        `node ./shit.js file://#{File.expand_path(workdir)}/#{text_document.name} #{workdir}/index.pdf`
        `gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=#{workdir}/gs-index.pdf #{workdir}/index.pdf`
      end
    end
  end
end
