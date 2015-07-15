require_relative "../matrix_aes_additions.rb"

include Matrix

describe "Matrix AES additions" do
  it "should create matrix_128 from string" do
    matrix_128 = Matrix_128.new_with_string("ATTACK AT DAWN!!")
    matrix_128.get_bytes.should eql [65, 84, 84, 65, 67, 75, 32, 65, 84, 32, 68, 65, 87, 78, 33, 33]
  end
end
