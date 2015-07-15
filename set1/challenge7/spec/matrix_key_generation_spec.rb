require_relative "../matrix_key_generation.rb"

describe "Matrix key generation" do
  it "should generate next key" do
    matrix_128 = Matrix_128.new([43, 126, 21, 22, 40, 174, 210, 166, 171, 247, 21, 136, 9, 207, 79, 60])

    matrix_128.generate_next
    matrix_128.get_column(0).should eql [160, 250, 254, 23]
    matrix_128.get_column(1).should eql [136, 84, 44, 177]
    matrix_128.get_column(2).should eql [35, 163, 57, 57]
    matrix_128.get_column(3).should eql [42, 108, 118, 5]

    matrix_128.generate_next
    matrix_128.get_column(0).should eql [242, 194, 149, 242]
    matrix_128.get_column(1).should eql [122, 150, 185, 67]
    matrix_128.get_column(2).should eql [89, 53, 128, 122]
    matrix_128.get_column(3).should eql [115, 89, 246, 127]
  end
end
