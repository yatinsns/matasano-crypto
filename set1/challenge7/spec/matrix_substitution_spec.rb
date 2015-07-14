require_relative "../matrix_substitution.rb"

describe "Matrix Substitution" do
  it "should substitute matrix_128" do
    matrix = Matrix_128.new([25, 61, 227, 190, 160, 244, 226, 43, 154, 198, 141, 42, 233, 248, 72, 8])
    new_matrix = Matrix.get_matrix_128_after_substitution matrix

    new_matrix.get_row(0).should eql [212, 224, 184, 30]
    new_matrix.get_row(1).should eql [39, 191, 180, 65]
    new_matrix.get_row(2).should eql [17, 152, 93, 82]
    new_matrix.get_row(3).should eql [174, 241, 229, 48]
  end
end
