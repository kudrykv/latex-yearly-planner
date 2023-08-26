# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class Notes
      def initialize(**options)
        @notes = case options[:type].downcase.to_sym
                 when :dotted
                   NotesDotted.new(**options)
                 when :lined
                   Lined.new(**options)
                 else
                   raise ArgumentError, "Unknown notes type: #{options[:type]}"
                 end
      end

      def respond_to_missing?(...)
        @notes.respond_to?(...)
      end

      def method_missing(...)
        @notes.send(...)
      end

      def to_s
        @notes.to_s
      end
    end
  end
end
