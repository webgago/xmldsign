module Xmldsign
  class Document < DelegateClass(XML::Document)
    def self.string(xml)
      new LibXML::XML::Document.string(xml)
    end

    def signature
      if (node = find_first('.//ds:Signature'))
        Signature.new node
      else
        raise Xmldsign::NodeError, 'node ds:Signature is not found in document'
      end
    end
  end
end
