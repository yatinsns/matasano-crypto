require_relative "../ecb_cut_paste.rb"
require_relative "../../../set1/challenge7/aes_128_ecb.rb"

describe "ECB cut and paste" do
  it "should return encoded profile for email" do
    expect(profile("yatinsns@gmail.com")).to match(/email=yatinsns@gmail.com&uid=.*&role=user/)
  end

  it "should encrypt encoded profile for email" do
    cipher_text = oracle "yatinsns@gmail.com"
    expect(decrypt(cipher_text)).to match(/email=yatinsns@gmail.com&uid=.*&role=user/)
  end
end
