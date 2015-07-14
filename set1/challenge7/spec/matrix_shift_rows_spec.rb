require_relative "../matrix_shift_rows.rb"

describe "Matrix Shift Rows" do
  it "should shift row matrix_128" do
    matrix = Matrix_128.new([212, 39, 17, 174, 224, 191, 152, 241, 184, 180, 93, 229, 30, 65, 82, 48])
    matrix.shift_row

    matrix.get_row(0).should eql [212, 224, 184, 30]
    matrix.get_row(1).should eql [191, 180, 65, 39]
    matrix.get_row(2).should eql [93, 82, 17, 152]
    matrix.get_row(3).should eql [48, 174, 241, 229]
  end
end
