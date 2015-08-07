require_relative "../mix_columns.rb"

describe "MixColumns" do
  it "should return correct mult 2 value" do
    MixColumns.mult_2(255).should eql 229
  end

  it "should return correct mult 3 value" do
    MixColumns.mult_3(255).should eql 26
  end

  it "should return correct mult 9 value" do
    MixColumns.mult_9(255).should eql 70
  end

  it "should return correct mult 11 value" do
    MixColumns.mult_11(255).should eql 163
  end

  it "should return correct mult 13 value" do
    MixColumns.mult_13(255).should eql 151
  end

  it "should return correct mult 14 value" do
    MixColumns.mult_14(255).should eql 141
  end
end
