require_relative "../ecb_oracle.rb"
require_relative "../../challenge9/pkcs7.rb"

EXPECTED_RESULT = "Rollin' in my 5.0
With my rag-top down so my hair can blow
The girlies on standby waving just to say hi
Did you stop? No, I just drove by
"

describe "ECB Oracle" do
  it "should find out the suffix" do
    expect(hack_ecb_oracle).to eql(EXPECTED_RESULT)
  end

  it "should get correct length for suffix" do
    expected_length = PKCS7::pkcs7_padding_add(EXPECTED_RESULT, 16).length
    expect(hack_ecb_oracle_length).to eql(expected_length)
  end

  it "should get block_size" do
    expect(hack_ecb_oracle_block_size).to eql(16)
  end
end
