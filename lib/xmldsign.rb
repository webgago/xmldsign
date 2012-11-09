require "xmldsign/version"
require "xmldsign/error"
require "xmldsign/digests/gost"
require "libxml"
require "libxslt"
require "delegate"
require "base64"

module Xmldsign
  include LibXML

  class NodeError < Error
  end

  autoload :Algorithms, 'xmldsign/algorithms'
  autoload :Document, 'xmldsign/document'
  autoload :Signature, 'xmldsign/signature'
  autoload :SignedInfo, 'xmldsign/signed_info'
  autoload :Transforms, 'xmldsign/transforms'
end

