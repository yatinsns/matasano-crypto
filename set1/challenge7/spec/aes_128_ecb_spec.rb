require_relative "../aes_128_ecb.rb"

describe "AES" do
  it "should encrypt 128 bits in ECB mode" do
    base64_encoding = AES.encrypt_128_ecb("abcdefghijklmnop", "YELLOW SUBMARINE", false)
    base64_encoding.should eql "vbGE1E4fwdMGCUW1PJlPSA=="
  end

  it "should decrypt 128 bits in ECB mode" do
    base64_encoding = AES.decrypt_128_ecb("vbGE1E4fwdMGCUW1PJlPSA==", "YELLOW SUBMARINE", false)
    base64_encoding.should eql "YWJjZGVmZ2hpamtsbW5vcA=="
   end
end
