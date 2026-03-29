# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class CoverPlain
          attr_reader :section_name

          def initialize(section_name:, name:, font_size:, **_rest)
            self.section_name = section_name
            self.name = name
            self.font_size = font_size
          end

          def register(_manifest); end

          def pages(_manifest)
            [PageData.new(raw_typst: true, content: cover)]
          end

          private

          attr_writer :section_name
          attr_accessor :name, :font_size

          def cover
            <<~TYPST.strip
              #grid(
                columns: 1fr,
                rows: 1fr,
                align: center + horizon,
                stroke: 0pt,

                text(size: #{font_size})[#{name}]
              )
            TYPST
          end
        end
      end
    end
  end
end
