require_relative "../detection_oracle.rb"

describe "Detection Oracle" do
  context "AESRandom" do
    it "should test random key generation of length 16 byte" do
      expect(AESRandom::generate_random_key(16).length).to eql(16)
    end

    it "should generate random cipher amond cbc/ecb" do
      cipher = AESRandom::generate_random_cipher
      expect(cipher).to match(/(cbc|ecb)/)
    end

    it "should generate random iv bytes array" do
      random_iv_bytes = AESRandom::random_iv_bytes(16)
      expect(random_iv_bytes.length).to eql(16)
      random_iv_bytes.each do |byte|
        expect(byte).to be < 256
      end
    end
  end

  it "should encrypt" do
    input = "abcdefghijklmnop"
    puts encryption_oracle(input)
  end

  it "should detect" do
    detect_cipher(method :encryption_oracle)
  end
end
