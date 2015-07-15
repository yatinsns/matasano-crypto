require_relative "../matrix_mix_columns.rb"

describe "Matrix mix columns" do
  it "should mix columns for matrix_128" do
    matrix_128 = Matrix_128.new([212, 191, 93, 48, 224, 180, 82, 174, 184, 65, 17, 241, 30, 39, 152, 229])
    matrix_128.mix_columns

    matrix_128.get_column(0).should eql [4, 102, 129, 229]
    matrix_128.get_column(1).should eql [224, 203, 25, 154]
    matrix_128.get_column(2).should eql [72, 248, 211, 122]
    matrix_128.get_column(3).should eql [40, 6, 38, 76]
  end
end
