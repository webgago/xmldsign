module Xmldsign
  class Transforms < DelegateClass(XML::Node)
    def execute(document=self.doc)
      doc = LibXML::XML::Document.new
      doc.root = document.root.copy(true)
      algorithms.inject(doc) { |d, algorithm| algorithm.execute d }
    end

    def algorithms
      find('.//ds:Transform').map { |t| factory(t['Algorithm'], t) }
    end

    def factory(algorithm, node)
      Algorithms.factory(algorithm, node)
    end
  end
end
