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
        doc.find_first('.//ds:Signature').remove!
        doc
      end
    end

    class XSLT
      attr_reader :transform_node

      def initialize(transform_node)
        @transform_node = transform_node
      end

      def stylesheet
        doc      = LibXML::XML::Document.new
        doc.root = transform_node.find('*[1]').first.copy(true)
        LibXSLT::XSLT::Stylesheet.new(doc)
      end

      def execute(doc)
        stylesheet.apply doc
      end
    end

    class Canonicalization
      XML_C14N_1_0           = 0
      XML_C14N_EXCLUSIVE_1_0 = 1
      XML_C14N_1_1           = 2

      attr_reader :transform_node

      def initialize(transform_node)
        @transform_node = transform_node
      end

      def execute(doc)
        raise NotImplementedError
      end
    end

    class C14NExc < Canonicalization
      def execute(doc)
        doc.canonicalize mode: XML_C14N_EXCLUSIVE_1_0
      end
    end

    ALGORITHMS = {
        # Digests

        "http://www.w3.org/2001/04/xmldsig-more#gostr3411"      => Gostr3411,

        # Transforms and Canonicalize

        "http://www.w3.org/2000/09/xmldsig#enveloped-signature" => Enveloped,
        "http://www.w3.org/TR/1999/REC-xslt-19991116"           => XSLT,
        "http://www.w3.org/2001/10/xml-exc-c14n#"               => C14NExc,
    }

    module_function :factory
  end
end
