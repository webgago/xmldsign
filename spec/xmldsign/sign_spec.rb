require 'spec_helper'

describe Xmldsign do

  subject{ Xmldsign::Document.string asset('act-birth-for-sign.xml') }

  it "should execute transformations" do
    subject.signature.sign.to_s.should eql asset('signed-act-birth.xml')
  end

end
