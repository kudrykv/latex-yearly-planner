# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class FileWriter
      def initialize(file_path)
        @file_path = file_path
      end

      def write(tree)
        FileUtils.mkdir_p(file_path)

        tree[:notes].each { |note| File.write("#{file_path}/#{note.name}.tex", note.contents) }
        File.write("#{file_path}/#{tree[:index].name}.tex", tree[:index].contents)
      end

      private

      attr_reader :file_path
    end
  end
end
