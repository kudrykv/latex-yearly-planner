# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class Indexer
      attr_reader :planner_config, :template

      def initialize(planner_config:)
        @planner_config = planner_config
        @template = ERB.new(File.read('./lib/latex_yearly_planner/erb/document.tex.erb'))
      end

      def index(text_documents)
        [index_text_file(text_documents), *text_documents]
      end

      def document_options
        planner_config.document_options
      end

      def document_class
        planner_config.document_class
      end

      def paper
        planner_config.paper
      end

      private

      # binding uses the `text_documents`
      # noinspection RubyUnusedLocalVariable
      def index_text_file(text_documents)
        content = template.result(binding)
        Entities::TextDocument.new(name: 'index.tex', content:)
      end
    end
  end
end