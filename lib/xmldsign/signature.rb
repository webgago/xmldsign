require "xmldsign/version"
require "nokogiri"
require "delegate"

module Xmldsign
  class Signature < DelegateClass(XML::Node)
    XML_C14N_1_0           = 0
    XML_C14N_EXCLUSIVE_1_0 = 1
    XML_C14N_1_1           = 2

    def signed_info
      SignedInfo.new find_first('.//ds:SignedInfo')
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

    def canonicalized
      canonicalization_method.execute
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
        node.content = digest_value
      else
        raise Xmldsign::NodeError, 'node ds:DigestValue is not found in document'
      end
    end

    def digest_value
      digest_method.execute transforms.execute
    end
  end
end

