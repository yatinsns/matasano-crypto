require './xor.rb'

describe "xor" do
  describe "matasano crypto set1 challenge2" do
    it "should test given input" do
      result_string = xor("1c0111001f010100061a024b53535009181c", "686974207468652062756c6c277320657965")
      result_string.should eql "746865206b696420646f6e277420706c6179"
    end
  end
end
