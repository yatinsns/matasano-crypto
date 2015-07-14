require_relative "../substitution.rb"

describe "Substitution" do
  it "should get correct sub byte for given input" do
    Substitution.sub_byte(248).should eql 65
  end

  it "should get correct inverse sub byte for given input" do
    Substitution.sub_byte_inverse(160).should eql 71
  end
end
