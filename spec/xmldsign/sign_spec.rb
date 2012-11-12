require 'spec_helper'

describe Xmldsign do
  LibXML::XML.default_pedantic_parser = true
  LibXML::XML.indent_tree_output      = false
  subject { Xmldsign::Document.string asset('act-birth-for-sign.xml') }

  it "should execute transformations" do
    subject.signature.sign.to_s.should eql asset('signed-act-birth.xml')
  end

  it "should calculate digest value" do
    subject.signature.calculate_digest.should eql 'ZtonhLsw3V9Sr14iQUvwMJoTo0RbnXMFca2z29xIPxw='
  end

  it "should insert digest value to SignedInfo in original xml" do
    subject.signed.find_first('.//ds:DigestValue').content.should eql 'ZtonhLsw3V9Sr14iQUvwMJoTo0RbnXMFca2z29xIPxw='
  end

  it "should have canonicalized SignedInfo" do
    subject.signature.c14n_signed_info.should eql asset('signed-info-for-act-birth.xml').strip
  end

  it "should sign all xml in assets" do
    assets = %w(signed-act-birth-with-comment.xml
                signed-act-birth.xml
                signed-act-changed-ns-order.xml
                signed-act-changed-prefixes.xml
                signed-act-changed-xml-comments.xml
                signed-act-death-with-empty-tags.xml
                signed-act-death.xml
                signed.test.xml
                null-pointer.xml)

    assets.each do |name|
      xml = Xmldsign::Document.string asset name
      xml.signature.sign

      xml = Xmldsign::Document.string asset name
      xml.signature.calculate_digest

      xml = Xmldsign::Document.string asset name
      xml.signature.fill_digest!
    end

    #Xmldsign::Document.string asset 'transformed.xml'
    xml = Xmldsign::Document.string asset 'null-pointer.xml'
    xml.signature.calculate_digest.should eql 'lnQAJP6l90PT5WyCn37XOH1iayU4j5MjF2cpCzwWgBc='
  end
end
