# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class TodoIndex < Face
          attr_reader :page_number

          def set(page_number)
            @page_number = page_number

            self
          end

          def title
            label = i18n.t('todo.index')
            label += " #{page_number}" if params.get(:pages) > 1

            "text(#{params.get(:heading_size)})[#{label}<ti-#{page_number}>]"
          end

          def content
            <<~TYPST
              table(
                columns: (#{(['1fr'] * columns).join(", #{gap_width},")}),
                inset: 0mm,
                stroke: 0mm,
                #{table_rows}
              )
            TYPST
          end

          def extra_menu_items
            (1..pages).map do |page|
              next "[#{i18n.t('todo.menu_index')}]" if pages == 1
              next "black_table_cell(text(white)[#{i18n.t('todo.menu_index')} #{page}])" if page == page_number

              "link(<ti-#{page}>, [#{i18n.t('todo.menu_index')} #{page}])"
            end
          end

          private

          def pages
            params.get(:pages)
          end

          def columns
            @columns ||= params.get(:columns)
          end

          def rows
            @rows ||= params.get(:rows)
          end

          def items_on_page
            @items_on_page ||= columns * rows
          end

          def offset
            @offset ||= (page_number - 1) * items_on_page
          end

          def table_rows
            ((offset + 1)..(items_on_page + offset)).each_slice(rows).to_a.transpose.map(&method(:table_row)).join(",\n")
          end

          def table_row(row)
            row.map do |item|
              <<~TYPST
                box(
                  height: #{params.get(:cell_height)},
                  width: 100%,
                  stroke: (bottom: 0.4pt + gray),
                  align(horizon, [#{item}.])
                )
              TYPST
            end.join(', [], ')
          end

          def gap_width
            params.get(:gap_width)
          end
        end
      end
    end
  end
end
