# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class SetCell
      attr_accessor :content, :stretch_columns, :stretch_rows, :bg_color, :fg_color, :colspec

      def initialize(content, **options)
        @content = content

        @stretch_columns = options.fetch(:stretch_columns, nil)
        @stretch_rows = options.fetch(:stretch_rows, nil)
        @bg_color = options.fetch(:bg_color, nil)
        @fg_color = options.fetch(:fg_color, nil)
        @colspec = options.fetch(:colspec, nil)
      end

      def to_s
        "{\\SetCell#{stretch}{#{make_options}}#{content}}"
      end

      def selected
        self.bg_color = 'black'
        self.fg_color = 'white'

        self
      end

      private

      def stretch
        return '' unless stretch_columns || stretch_rows

        out = []

        out << "c=#{stretch_columns}" if stretch_columns
        out << "r=#{stretch_rows}" if stretch_rows

        "[#{out.join(',')}]"
      end

      def make_options
        [
          make_colspec,
          make_bg_color,
          make_fg_color
        ].compact.join(',')
      end

      def make_colspec
        return 'c' unless colspec

        colspec
      end

      def make_bg_color
        "bg=#{bg_color}" if bg_color
      end

      def make_fg_color
        "fg=#{fg_color}" if fg_color
      end
    end
  end
end
