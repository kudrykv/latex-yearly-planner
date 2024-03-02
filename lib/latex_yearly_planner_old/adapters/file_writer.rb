# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class FileWriter
      attr_accessor :index_file

      def initialize(file_path)
        @file_path = file_path
      end

      def write(tree)
        FileUtils.mkdir_p(file_path)

        tree[:notes].each { |note| write_note_to_file(note) }
        write_note_to_file(tree[:index])

        self.index_file = "#{tree[:index].name}.tex"
      end

      private

      def write_note_to_file(note)
        File.write("#{file_path}/#{note.name}.tex", note.contents)
      end

      attr_reader :file_path
    end
  end
end
