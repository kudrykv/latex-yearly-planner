# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class Header < Component
          def top_table(...)
            table = TeX::Tabular.new(**parameters(:header, :top_table))
            table.add_row([calendar_cell(...), index_notes_cell(...), index_todos_cell(...)].compact)

            table
          end

          def calendar_cell(...)
            return unless config.sections.annual.enabled

            cell = TeX::Cell.new('Calendar')
            cell.selected = true if section_name == :annual

            link_year(cell, year:, page: year_page_from_date(...))
          end

          def year_page_from_date(**kwargs)
            months_per_page = config.sections.annual.parameters.months_per_page.to_f

            (PROCS.fetch(kwargs.keys.first, PROCS[:fallback]).call(kwargs.values.first, year) / months_per_page).ceil
          end

          PROCS = {
            quarter: ->(quarter, year) { quarter.months.find { |month| month.year == year }.mon },
            month: ->(month, _year) { month.mon },
            week: ->(week, year) { week.months.find { |month| month.year == year }.mon },
            day: ->(day, _year) { day.month.mon },

            fallback: ->(_, _) { 1 }
          }.freeze

          attr_accessor :index_notes_disable_highlight, :index_todos_disable_highlight

          def index_notes_cell(...)
            return unless config.sections.index_notes.enabled

            cell = TeX::Cell.new('Notes')
            cell.selected = true if section_name == :index_notes && !index_notes_disable_highlight

            link_reference(cell, reference: NOTES_INDEX_REFERENCE, page: notes_page(...))
          end

          def notes_page(**kwargs)
            notes_per_page = config.sections.index_notes.parameters.notes_per_page.to_f

            return 1 unless kwargs.key? :note

            (kwargs[:note] / notes_per_page).ceil
          end

          def index_todos_cell(...)
            return unless config.sections.index_todos.enabled

            cell = TeX::Cell.new('Todo')
            cell.selected = true if section_name == :index_todos && !index_todos_disable_highlight

            link_reference(cell, reference: TODOS_INDEX_REFERENCE, page: todos_page(...))
          end

          def todos_page(**kwargs)
            todos_per_page = config.sections.index_todos.parameters.todos_per_page.to_f

            return 1 unless kwargs.key? :todo

            (kwargs[:todo] / todos_per_page).ceil
          end

          def margin_note(highlight_quarters: [], highlight_months: [])
            <<~LATEX
              \\marginnote{%
                #{quarter_table_from_months(highlight_quarters:)}
                \\\\[#{param(:header, :between_tables_spacing)}]
                #{table_from_months(highlight_months:)}
              }
            LATEX
              .strip
          end

          def quarter_table_from_months(highlight_quarters:)
            table = TeX::TabularX.new(**parameters(:header, :quarterly_table))

            all_quarters.map do |quarter|
              cell = TeX::Cell.new(quarter.name)
              cell.selected = true if highlight_quarters.include?(quarter)

              table.add_row([link_quarter(cell, quarter:)])
            end

            table
          end

          def table_from_months(highlight_months:)
            table = TeX::TabularX.new(**parameters(:header, :monthly_table))

            all_months.each do |month|
              cell = TeX::Cell.new(month.name[0..2])
              cell.selected = true if highlight_months.include?(month)

              table.add_row([link_month(cell, month:)])
            end

            table
          end
        end
      end
    end
  end
end
