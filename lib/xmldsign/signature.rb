module Xmldsign
  class Signature < DelegateClass(XML::Node)
    XML_C14N_1_0           = 0
    XML_C14N_EXCLUSIVE_1_0 = 1
    XML_C14N_1_1           = 2

    def signed_info
      SignedInfo.new find_first('.//ds:SignedInfo')
    end

    def c14n_signed_info
      sign
      doc = LibXML::XML::Document.new
      doc.root = signed_info.copy(true)
      doc.canonicalize mode: XML_C14N_EXCLUSIVE_1_0
    end

    def canonicalization_method
      node = find_first('.//ds:CanonicalizationMethod')
      Algorithms.factory node['Algorithm'], node
    end

    def digest_method
      node = find_first('.//ds:DigestMethod')
      Algorithms.factory node['Algorithm'], node
    end

    def transforms
      signed_info.transforms
    end

    def sign
      fill_digest!
      clear_signature_value!
      clear_certificate!
      doc
    end

    def clear_signature_value!
      if (node = find_first('.//ds:SignatureValue'))
        node.content = ''
      end
    end

    def clear_certificate!
      if (node = find_first('.//ds:X509Certificate'))
        node.content = ''
      end
    end

    def fill_digest!
      if (node = find_first('.//ds:DigestValue'))
        node.content = calculate_digest
      else
        raise Xmldsign::NodeError, 'node ds:DigestValue is not found in document'
      end
    end

    def calculate_digest
      digest_method.execute transforms.execute
    end
  end
end

