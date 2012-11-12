require "xmldsign/xmldsign_ext"

module Xmldsign
  module Digests
    class Gost
      attr_reader :data

      class << self
        def base64(data)
          new(data).base64
        end
        def hex(data)
          new(data).hex
        end
        def binary(data)
          new(data).binary
        end
      end

      def initialize(data)
        @data = data.to_s
      end

      def base64
        Base64.strict_encode64(binary(data))
      end

      def hex
        binary(data).bytes.inject("") { |hex, b| hex << b.to_s(16) }
      end
    end
  end
end
