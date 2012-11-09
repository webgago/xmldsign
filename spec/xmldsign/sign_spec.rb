require 'spec_helper'

describe Xmldsign do
  LibXML::XML.default_pedantic_parser = true
  LibXML::XML.indent_tree_output = false
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

end
