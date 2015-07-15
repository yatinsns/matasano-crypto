require_relative "../aes.rb"

describe "AES" do
  it "should encrypt 128 bits in ECB mode" do
    base64_encoding = AES.encrypt_128_ecb("ATTACK AT DAWN!!", "YELLOW SUBMARINE")
    base64_encoding.should eql "CjLau5wzO7F+j4g/LK0UMQ=="
  end
end
