# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    class InitializeTextDocumentsWriter
      include Interactor

      def call
        context.text_documents_writer = Adapters::TextDocumentsWriter.new(output_path: generated_files_output_path)
      end

      private

      def generated_files_output_path
        raise DevelopmentError, 'generated_files_output_path is not defined' unless context.generated_files_output_path

        context.generated_files_output_path
      end
    end
  end
end
