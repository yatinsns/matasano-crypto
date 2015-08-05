require_relative "../matrix_substitution.rb"

describe "Matrix Substitution" do
  it "should substitute matrix_128" do
    matrix = Matrix_128.new([25, 61, 227, 190, 160, 244, 226, 43, 154, 198, 141, 42, 233, 248, 72, 8])
    matrix.substitute

    matrix.get_row(0).should eql [212, 224, 184, 30]
    matrix.get_row(1).should eql [39, 191, 180, 65]
    matrix.get_row(2).should eql [17, 152, 93, 82]
    matrix.get_row(3).should eql [174, 241, 229, 48]
  end

  it "should inverse substitute matrix_128" do
    matrix = Matrix_128.new([212, 39, 17, 174, 224, 191, 152, 241, 184, 180, 93, 229, 30, 65, 82, 48])
    matrix.inverse_substitute

    matrix.get_row(0).should eql [25, 160, 154, 233]
    matrix.get_row(1).should eql [61, 244, 198, 248]
    matrix.get_row(2).should eql [227, 226, 141, 72]
    matrix.get_row(3).should eql [190, 43, 42, 8]
  end
end
