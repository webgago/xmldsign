require "xmldsign/version"
require "libxml"
require "libxslt"
require "delegate"

module Xmldsign
  include LibXML

  class Error < StandardError
  end

  class NodeError < Error
  end

  autoload :Algorithms, 'xmldsign/algorithms'
  autoload :Document, 'xmldsign/document'
  autoload :Signature, 'xmldsign/signature'
  autoload :SignedInfo, 'xmldsign/signed_info'
  autoload :Transforms, 'xmldsign/transforms'
end

