# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Components
        class AnnualHeader < Component
          def generate(_months, _page_number)
            <<~LATEX
              \\marginnote{#{in_margin_note}}%
              #{heading_table}%
              #{XTeX::Line.new}%
              \\vskip#{params.get(:header_separation)}
            LATEX
              .strip
          end

          private

          def heading_table
            row = TeX::TableRow.new(heading_table_cell_parts.flatten)

            table = TeX::TabularX.new(**params.object(:heading).to_h)
            table.formatting = TeX::TableFormatting.new(heading_table_layout_parts.join)
            table.add_row(row)
            table
          end

          def heading_table_layout_parts
            @heading_table_layout_parts ||= params
                                            .placement(:heading)
                                            .map { |item| item.position || "|#{heading_table_nav_layout_part}|" }
          end

          def heading_table_nav_layout_part
            @heading_table_nav_layout_part ||= heading_table_nav.size.times.map { 'l' }.split.join('|')
          end

          def heading_table_cell_parts
            @heading_table_cell_parts ||= params.placement(:heading).map { |item| method(item.function).call }
          end

          def heading_table_nav
            @heading_table_nav ||= heading_table_cell_parts.find { |cp| cp.is_a?(Array) }
          end

          def page_name
            TeX::TableCell.new(heading_name)
          end

          def heading_name
            first = params.months.first
            last = params.months.last

            return first.year if first.year == last.year && first.january? && last.december?

            "#{first.year}, #{short_month_name(first)} -- #{last.year}, #{short_month_name(last)}"
          end

          def empty_cell_filler
            TeX::TableCell.new
          end

          def top_navigation
            [TeX::TableCell.new('one'), TeX::TableCell.new('two')]
          end

          def in_margin_note
            params.placement(:side_navigation).map do |placement|
              next "\\vskip#{placement}" if placement.match?(/\A\d/)

              method(placement).call
            end.join("%\n")
          end

          def quarters_navigation
            XTeX::VerticalStick.new(items: quarter_names, **quarter_navigation_params)
          end

          def quarter_names
            params.quarters.map do |quarter|
              "#{i18n.t('calendar.one_letter.quarter')}#{quarter.number}"
            end
          end

          def quarter_navigation_params
            params.object(:quarters_navigation).to_h
          end

          def months_navigation
            XTeX::VerticalStick.new(items: month_names, **month_navigation_params)
          end

          def month_names
            params.months.map(&method(:short_month_name))
          end

          def short_month_name(month)
            i18n.t("calendar.short.month.#{month.name.downcase}")
          end

          def month_navigation_params
            params.object(:months_navigation).to_h
          end
        end
      end
    end
  end
end
