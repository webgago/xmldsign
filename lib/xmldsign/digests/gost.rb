require "anyhash"

module Xmldsign
  module Digests
    class Gost

      attr_reader :data

      def initialize(data)
        @data = data.to_s
      end

      def base64
        [[hex].pack('H*')].pack('m0')
      end

      def hex
        Anyhash.gost_cryptopro(data)
      end

      class << self

        def base64(data)
          new(data).base64
        end

        def hex(data)
          new(data).hex
        end

      end

    end
  end
end
