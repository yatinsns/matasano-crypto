require_relative "../aes_128_ecb.rb"

describe "AES" do
  it "should encrypt 128 bits in ECB mode without padding" do
    base64_encoding = AES.encrypt_128_ecb("abcdefghijklmnop", "YELLOW SUBMARINE", false)
    base64_encoding.should eql "vbGE1E4fwdMGCUW1PJlPSA=="
  end

  it "should encrypt more than 128 bits in ECB mode with padding" do
    base64_encoding = AES.encrypt_128_ecb("Rollin' in my 5.0\nWith my rag-top down so my hair can blow\nThe girlies on standby waving just to say hi\nDid you stop? No, I just drove by\n", "YELLOW SUBMARINE", true)
    base64_encoding.should eql "cuOUaQATt87kAN3H0MTJO/dJaqRKo4scCm9DIbVxchr56jI2Hsn5oWlqHxwk10I2cYqzfoHCUKTKl6r5XYj1w/XD9UxdEJ2l44Az5MXa+J2ueLxF7bTc9X0vH+mv3pP0zGhvwGCUTrjFQrKhvqwRYMxZTt74816hiqmz4Lv0VWSLH/NmWIHyLS1HENp1nj1V"
  end

  it "should encrypt 128 bits in ECB mode with padding" do
    base64_encoding = AES.encrypt_128_ecb("abcdefghijklmnop", "YELLOW SUBMARINE", true)
    base64_encoding.should eql "vbGE1E4fwdMGCUW1PJlPSGD6NnB+RfSZ26DyW5IjAaU="
  end

  it "should decrypt 128 bits in ECB mode" do
    base64_encoding = AES.decrypt_128_ecb_base64("vbGE1E4fwdMGCUW1PJlPSA==", "YELLOW SUBMARINE", false)
    base64_encoding.should eql "YWJjZGVmZ2hpamtsbW5vcA=="
  end

  it "should decrypt 128 bits in ECB mode" do
    base64_encoding = AES.decrypt_128_ecb_base64("vbGE1E4fwdMGCUW1PJlPSGD6NnB+RfSZ26DyW5IjAaU=", "YELLOW SUBMARINE", true)
    base64_encoding.should eql "YWJjZGVmZ2hpamtsbW5vcA=="
  end
end
