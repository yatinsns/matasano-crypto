require_relative "../pkcs7.rb"

describe "pkcs7" do
  it "should add pkcs7 padding when length is not a multiple of block size" do
    message = "ATTACK"
    pkcs7_padding(message, 5).should eql "ATTACK\x04\x04\x04\x04"
  end

  it "should add pkcs7 padding when length is a multiple of block size" do
    message = "FIGHT"
    pkcs7_padding(message, 5).should eql "FIGHT\x05\x05\x05\x05\x05"
  end
end
