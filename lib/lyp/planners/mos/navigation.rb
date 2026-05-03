# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      class Navigation
        NavLink = Data.define(:id, :label)

        def initialize(i18n:, manifest:, configurator:)
          self.i18n = i18n
          self.manifest = manifest
          self.mos_layout = configurator.dig!(:planner, :params, :mos_layout)
          self.heading = configurator.dig!(:planner, :params, :heading)
          self.start_date = configurator.start_date
          self.end_date = configurator.end_date
        end

        def side_menu_cell(highlight_months:, highlight_quarters:)
          cols = %w[1fr 3fr]
          items = [quarters_menu(highlight_quarters:), months_menu(highlight_months:)]

          if mos_layout.dig!(:reverse_months_quarters)
            cols.reverse!
            items.reverse!
          end

          <<~TYPST.strip
            grid.cell(
              rowspan: 2,

              rotate(
                #{mos_layout.dig!(:menu_rotate)},
                origin: center + horizon,
                reflow: true,

                table(
                  columns: (#{cols.join(", ")}),
                  rows: 1fr,
                  inset: 0pt,
                  column-gutter: regular_column_gutter,
                  stroke: 0pt,

                  #{items.join(",\n")}
                )
              )
            )
          TYPST
        end

        def heading_menu_grid(page_id:)
          links = nav_links(page_id:)
          return nil if links.empty?

          <<~TYPST
            grid(
              rows: #{heading.dig!(:height)},
              columns: #{links.length},
              inset: 7pt,

              stroke: (x, y)  => if x > 0 { ( left: regular_stroke ) },
              #{links.join(", ")}
            )
          TYPST
        end

        private

        attr_accessor :i18n, :manifest, :mos_layout, :heading, :start_date, :end_date

        def candidate_links
          [NavLink.new(id: Sections::Annual::ID, label: "Calendar")]
        end

        def nav_links(page_id:)
          candidate_links.filter_map do |nav|
            next unless manifest.source?(nav.id)

            link = "padded_link(<#{nav.id}>, [#{nav.label}])"
            page_id == nav.id ? "grid.cell(fill: black, text(white)[##{link}])" : link
          end
        end

        def months_menu(highlight_months:)
          range = start_date.month..end_date.month
          range = range.to_a.reverse if mos_layout.dig!(:reverse_months_quarters_items)

          menu = Components::MonthsMenu.new(i18n:, manifest:, range:)
          menu.highlight(highlight_months)
          menu.generate
        end

        def quarters_menu(highlight_quarters:)
          range = start_date.quarter..end_date.quarter
          range = range.to_a.reverse if mos_layout.dig!(:reverse_months_quarters_items)

          menu = Components::QuartersMenu.new(i18n:, manifest:, range:)
          menu.highlight(highlight_quarters)
          menu.generate
        end
      end
    end
  end
end
