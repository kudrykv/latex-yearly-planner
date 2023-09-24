# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    module HyperHelpers
      NOTES_INDEX_REFERENCE = 'notes_index'
      NOTES_REFERENCE = 'notes'
      TODOS_INDEX_REFERENCE = 'todos_index'
      TODOS_REFERENCE = 'todos'

      def target_year(content, year:, page: 1)
        Hyper.new(content, page:, reference: year).target
      end

      def link_year(content, year:, page: 1)
        Hyper.new(content, page:, reference: year).link
      end

      def target_quarter(content, quarter:)
        Hyper.new(content, reference: quarter.reference).target
      end

      def link_quarter(content, quarter:)
        Hyper.new(content, reference: quarter.reference).link
      end

      def target_month(content, month:)
        Hyper.new(content, reference: month.reference).target
      end

      def link_month(content, month:)
        Hyper.new(content, reference: month.reference).link
      end

      def target_week(content, week:)
        Hyper.new(content, reference: week.reference).target
      end

      def link_week(content, week:)
        Hyper.new(content, reference: week.reference).link
      end

      def target_day(content, day:)
        Hyper.new(content, reference: day.reference).target
      end

      def link_day(content, day:)
        Hyper.new(content, reference: day.reference).link
      end

      def target_note(content, note)
        Hyper.new(content, reference: "note-#{note}").target
      end

      def target_todo(content, todo:, page: 1)
        Hyper.new(content, reference: todo_reference(todo), page:).target
      end

      def todo_reference(todo)
        "todo-#{todo}"
      end

      def target_reference(content, reference:, page: 1)
        Hyper.new(content, reference:, page:).target
      end

      def link_reference(content, reference:, page: 1)
        Hyper.new(content, reference:, page:).link
      end
    end
  end
end
