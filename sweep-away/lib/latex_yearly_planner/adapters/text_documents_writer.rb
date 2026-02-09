# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class TextDocumentsWriter
      attr_reader :workdir

      def initialize(workdir:)
        @workdir = workdir
      end

      def write(text_documents)
        FileUtils.mkdir_p(workdir)
        text_documents.each(&method(:write_text_document))
      end

      private

      def write_text_document(text_document)
        File.write("#{workdir}/#{text_document.name}", text_document.content)
      end
    end
  end
end
