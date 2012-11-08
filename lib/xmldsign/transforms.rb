module Xmldsign
  class Transforms < DelegateClass(XML::Node)

    def execute(document=self.doc)
      list.inject(Document.new document) { |d, transform| transform.execute d }
    end

    def list
      find('.//ds:Transform').map { |t| factory(t['Algorithm'], t) }
    end

    def factory(algorithm, node)
      Algorithms.factory(algorithm, node)
    end

  end
end
