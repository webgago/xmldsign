require 'openssl'

module Xmldsign
  module Algorithms
    def factory(uri, node)
      ALGORITHMS[uri].new(node)
    end

    class Gostr3411
      KEY = 'md_gost94'

      def initialize(transform_node)
        OpenSSL::Engine.load
        @engine = OpenSSL::Engine.by_id 'gost'
      end

      def execute(xml)
        openssl.base64digest xml
      end

      def openssl
        @engine.digest(KEY)
      end
    end

    class Enveloped
      def initialize(transform_node)
      end

      def execute(doc)
        doc.signature.parent.content = ''
        doc
      end
    end

    class XSLT
      attr_reader :transform_node

      def initialize(transform_node)
        @transform_node = transform_node
      end

      def stylesheet
        xslt = Nokogiri::XSLT transform_node.children.to_s
      end

      def execute(doc)
        stylesheet.transform doc
      end
    end

    class C14NExc
      attr_reader :transform_node

      def initialize(transform_node)
        @transform_node = transform_node
      end

      def execute(doc)
        doc.canonicalize Nokogiri::XML::XML_C14N_EXCLUSIVE_1_0
      end
    end

    ALGORITHMS = {
        # Digests

        "http://www.w3.org/2001/04/xmldsig-more#gostr3411"      => Gostr3411,

        # Transforms and Canonicalize

        "http://www.w3.org/2000/09/xmldsig#enveloped-signature" => Enveloped,
        "http://www.w3.org/TR/1999/REC-xslt-19991116"           => XSLT,
        "http://www.w3.org/2001/10/xml-exc-c14n#"               => C14NExc
    }

    module_function :factory
  end
end
