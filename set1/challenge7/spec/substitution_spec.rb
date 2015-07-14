require_relative "../substitution.rb"

describe "Substitution" do
  it "should get correct sub byte for given input" do
    Substitution.sub_byte(248).should eql "A"
  end

  it "should get correct inverse sub byte for given input" do
    Substitution.sub_byte_inverse(160).should eql "G"
  end
end
