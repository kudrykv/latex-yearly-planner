# frozen_string_literal: true

module LYP
  module Pkg
    class StrictHash
      extend Forwardable

      def initialize(hash, path: [])
        self.hash = hash
        @path = path.freeze
      end

      def dig!(*keys)
        raise ArgumentError, "no keys given" if keys.empty?

        value = hash.dig(*keys)
        full_path = path + keys

        raise ConfigError, "#{full_path.map(&:to_s).join(".")} not found" if value.nil?

        wrap(value, full_path)
      end

      def [](key)
        wrap(hash[key], path + [key])
      end

      def to_hash
        hash
      end

      def_delegators :@hash, :filter, :nil?, :empty?, :delete

      private

      attr_accessor :hash
      attr_reader :path

      def wrap(value, path)
        case value
        when Hash
          self.class.new(value, path:)
        when Array
          value.each_with_index.map do |item, i|
            item.is_a?(Hash) ? self.class.new(item, path: path + [i]) : item
          end
        else
          value
        end
      end
    end
  end
end
