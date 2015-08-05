require_relative "../aes.rb"

describe "AES" do
  it "should encrypt 128 bits in ECB mode" do
    base64_encoding = AES.encrypt_128_ecb("abcdefghijklmnopqrstuvwxyz", "YELLOW SUBMARINE")
    base64_encoding.should eql "vbGE1E4fwdMGCUW1PJlPSCEtYythlaDLlReyIuaEieo="
  end
end
