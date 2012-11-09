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
      end

      def initialize(data)
        @data = data.to_s
      end

      def base64
        Base64.encode64(binary).strip
      end

      def hex
        binary.bytes.inject("") { |hex, b| hex << b.to_s(16) }
      end
    end
  end
end
