module Xmldsign
  class SignedInfo < DelegateClass(XML::Node)
    def transforms
      Transforms.new find_first('.//ds:Transforms')
    end
  end
end
