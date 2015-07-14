require './conversion.rb'

describe "Base64" do 
  describe "matasano crypto challenge set 1 challenge 1" do
    it "checks given solution" do
      base64_string = hex_to_base64 "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
      base64_string.should eql "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
    end
  end
end
