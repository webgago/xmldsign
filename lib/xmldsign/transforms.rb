module Xmldsign
  class Transforms < DelegateClass(XML::Node)
    def execute
      signing_doc = LibXML::XML::Document.new
      signing_doc.root = signing_node.copy(true)
      algorithms.inject(signing_doc) { |d, algorithm| algorithm.execute d }
    end

    def signing_node
      if (reference_uri = reference[:URI] and not reference_uri.empty?)
        id = reference_uri.sub!('#', '')
        doc.find_first("//*[@wsu:Id='#{id}']")
      else
        doc.root
      end
    end

    def reference
      doc.find_first('.//ds:Reference')
    end

    def algorithms
      find('.//ds:Transform').map { |t| factory(t['Algorithm'], t) }
    end

    def factory(algorithm, node)
      Algorithms.factory(algorithm, node)
    end
  end
end
