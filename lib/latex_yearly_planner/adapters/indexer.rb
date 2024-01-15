# frozen_string_literal: true

require 'erb'

module LatexYearlyPlanner
  module Adapters
    class Indexer
      def initialize(config)
        text = File.read('./lib/latex_yearly_planner/erb/document.tex.erb')
        @template = ERB.new(text)
        @config = config
        @document = config.document
      end

      # noinspection RubyUnusedLocalVariable
      def generate(notes)
        LatexYearlyPlanner::Core::Entities::Note.new('index', template.result(binding))
      end

      private

      attr_reader :template, :config, :document

      def document_options
        size = config.document.document_class.size || ''
        options = config.document.document_class.options || ''

        [size, options].reject(&:empty?).join(',')
      end
    end
  end
end
