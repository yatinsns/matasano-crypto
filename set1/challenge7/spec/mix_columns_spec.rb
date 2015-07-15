require_relative "../mix_columns.rb"

describe "MixColumns" do
  it "should return correct mult 2 value" do
    MixColumns.mult_2(255).should eql 229
  end

  it "should return correct mult 2 value" do
    MixColumns.mult_3(255).should eql 26
  end
end
