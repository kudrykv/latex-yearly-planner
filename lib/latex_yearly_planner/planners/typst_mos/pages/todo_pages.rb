# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class TodoPages < Face
          attr_reader :todo_number

          def set(todo_number)
            @todo_number = todo_number

            self
          end

          def title
            <<~TYPST
              text(#{params.get(:heading_size)})[#{i18n.t('todo.single_page')} #{todo_number} <tp-#{todo_number}>]
            TYPST
          end

          def content
            <<~TYPST
              table(
                 columns: (#{(['1fr'] * columns).join(", #{gap_width},")}),
                 rows: (#{(['1fr'] * rows).join(', ')}),
                 inset: 0mm,
                 stroke: 0mm,
                 #{table_rows.join(",\n")}
              )
            TYPST
          end

          private

          def columns
            @columns ||= params.get(:columns)
          end

          def rows
            @rows ||= params.get(:rows)
          end

          def gap_width
            @gap_width ||= params.get(:gap_width)
          end

          def table_rows
            rows.times.map do
              columns.times.map do
                todos_block
              end.join(', [], ')
            end
          end

          def todos_block
            <<~TYPST
              pad(bottom: 5mm, table(
                columns: 1fr,
                inset: 0mm,
                stroke: (_, _) => (bottom: 0.4pt + black),
                #{todos_lines}
              ))
            TYPST
          end

          def todos_lines
            (["box(height: #{params.get(:todo_height)}, align(horizon, [$square.stroked$]))"] * params.get(:items_in_group)).join(",\n")
          end
        end
      end
    end
  end
end
