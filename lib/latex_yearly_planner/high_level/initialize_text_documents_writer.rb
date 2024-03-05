# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    class InitializeTextDocumentsWriter
      include Interactor

      def call
        context.text_documents_writer = Adapters::TextDocumentsWriter.new(workdir:)
      end

      private

      def workdir
        raise DevelopmentError, 'workdir is not defined' unless context.workdir

        context.workdir
      end
    end
  end
end
