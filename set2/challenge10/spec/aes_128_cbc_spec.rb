require_relative "../aes_128_cbc.rb"

describe "AES" do
  it "should encrypt 128 bits in CBC mode without padding" do
    base64_encoding = AES.encrypt_128_cbc("abcdefghijklmnop", "YELLOW SUBMARINE", false)
    base64_encoding.should eql "vbGE1E4fwdMGCUW1PJlPSA=="
  end

  it "should encrypt 128 bits in CBC mode with padding" do
    base64_encoding = AES.encrypt_128_cbc("abcdefghijklmnop", "YELLOW SUBMARINE", true)
    base64_encoding.should eql "vbGE1E4fwdMGCUW1PJlPSJRf9Jjuztd96LO39yk74kg="
  end

  it "should decrypt 128 bits in CBC mode" do
    base64_encoding = AES.decrypt_128_cbc_base64("vbGE1E4fwdMGCUW1PJlPSA==", "YELLOW SUBMARINE", false)
    base64_encoding.should eql "YWJjZGVmZ2hpamtsbW5vcA=="
  end

  it "should decrypt 128 bits in CBC mode" do
    base64_encoding = AES.decrypt_128_cbc_base64("vbGE1E4fwdMGCUW1PJlPSJRf9Jjuztd96LO39yk74kg=", "YELLOW SUBMARINE", true)
    base64_encoding.should eql "YWJjZGVmZ2hpamtsbW5vcA=="
  end
end
