require_relative "../pkcs7_validate_padding.rb"

describe "pkcs7" do
  it "should validate correct pkcs7 padding" do
    message = "ICE ICE BABY\x04\x04\x04\x04"
    expect(PKCS7::pkcs7_padding_remove_with_exception(message)).to eql("ICE ICE BABY")
  end

  it "should invalidate incorrect pkcs7 padding" do
    message = "ICE ICE BABY\x05\x05\x05\x05"
    begin
      PKCS7::pkcs7_padding_remove_with_exception(message)
      fail "This should show an exception"
    rescue
      puts "An error occured"
    end
  end

end
