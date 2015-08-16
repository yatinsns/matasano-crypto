require_relative "../pkcs7.rb"

include PKCS7

describe "pkcs7" do
  it "should add pkcs7 padding when length is not a multiple of block size" do
    message = "ATTACK"
    PKCS7::pkcs7_padding_add(message, 5).should eql "ATTACK\x04\x04\x04\x04"
  end

  it "should add pkcs7 padding when length is a multiple of block size" do
    message = "FIGHT"
    PKCS7::pkcs7_padding_add(message, 5).should eql "FIGHT\x05\x05\x05\x05\x05"
  end

  it "should remove pkcs7 padding when padding is less than block size" do
    message = "ABCABC\u0004\u0004\u0004\u0004"
    PKCS7::pkcs7_padding_remove(message).should eql "ABCABC"
  end

  it "should remove pkcs7 padding when padding is equal to block size" do
    message = "ABCA\u0004\u0004\u0004\u0004"
    PKCS7::pkcs7_padding_remove(message).should eql "ABCA"
  end
end
