# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class TextDocumentsWriter
      attr_reader :output_path

      def initialize(output_path:)
        @output_path = output_path
      end

      def write(text_documents)
        text_documents.each(&method(:write_text_document))
      end

      private

      def write_text_document(text_document)
        File.write("#{output_path}/#{text_document.name}", text_document.content)
      end
    end
  end
end
