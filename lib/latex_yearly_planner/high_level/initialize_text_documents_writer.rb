# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    class InitializeTextDocumentsWriter < Actor
      input :workdir, allow_nil: false
      output :text_documents_writer

      def call
        self.text_documents_writer = Adapters::TextDocumentsWriter.new(workdir:)
      end
    end
  end
end
