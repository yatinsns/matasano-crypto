require_relative "../add_round_key.rb"

describe "Matrix add round key" do
  it "should add round key matrix_128" do
    matrix_128 = Matrix_128.new([4, 102, 129, 229, 224, 203, 25, 154, 72, 248, 211, 122, 40, 6, 38, 76])
    key_matrix_128 = Matrix_128.new([160, 250, 254, 23, 136, 84, 44, 177, 35, 163, 57, 57, 42, 108, 118, 5])
    matrix_128.add_round_key key_matrix_128

    matrix_128.get_column(0).should eql [164, 156, 127, 242]
    matrix_128.get_column(1).should eql [104, 159, 53, 43]
    matrix_128.get_column(2).should eql [107, 91, 234, 67]
    matrix_128.get_column(3).should eql [2, 106, 80, 73]
  end
end
