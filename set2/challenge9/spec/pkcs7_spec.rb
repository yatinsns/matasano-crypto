require_relative "../pkcs7.rb"

describe "pkcs7" do
  it "should add pkcs7 padding when length is not a multiple of block size" do
    message = "ATTACK"
    pkcs7_padding_add(message, 5).should eql "ATTACK\x04\x04\x04\x04"
  end

  it "should add pkcs7 padding when length is a multiple of block size" do
    message = "FIGHT"
    pkcs7_padding_add(message, 5).should eql "FIGHT\x05\x05\x05\x05\x05"
  end

  it "should remove pkcs7 padding when padding is less than block size" do
    message = "ABCABC\u0004\u0004\u0004\u0004"
    pkcs7_padding_remove(message, 5).should eql "ABCABC"
  end

  it "should remove pkcs7 padding when padding is equal to block size" do
    message = "ABCA\u0004\u0004\u0004\u0004"
    pkcs7_padding_remove(message, 4).should eql "ABCA"
  end
end
