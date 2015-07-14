require_relative "../matrix.rb"

include Matrix

describe "Matrix" do
  describe "Matrix_128" do
    it "should get correct rows" do
      matrix = Matrix_128.new((1..16).to_a)
      matrix.get_row(0).should eql [1, 5, 9, 13]
      matrix.get_row(1).should eql [2, 6, 10, 14]
      matrix.get_row(2).should eql [3, 7, 11, 15]
      matrix.get_row(3).should eql [4, 8, 12, 16]
    end

    it "should get correct columns" do
      matrix = Matrix_128.new((1..16).to_a)
      matrix.get_column(0).should eql [1, 2, 3, 4]
      matrix.get_column(1).should eql [5, 6, 7, 8]
      matrix.get_column(2).should eql [9, 10, 11, 12]
      matrix.get_column(3).should eql [13, 14, 15, 16]
    end

    it "should set correct rows" do
      matrix = Matrix_128.new((1..16).to_a)
      matrix.set_row(0, [21, 22, 23, 24])
      matrix.set_row(1, [25, 26, 27, 28])
      matrix.set_row(2, [29, 30, 31, 32])
      matrix.set_row(3, [33, 34, 35, 36])

      matrix.get_row(0).should eql [21, 22, 23, 24]      
      matrix.get_row(1).should eql [25, 26, 27, 28]
      matrix.get_row(2).should eql [29, 30, 31, 32]
      matrix.get_row(3).should eql [33, 34, 35, 36]
    end

    it "should set correct columns" do
      matrix = Matrix_128.new((1..16).to_a)
      matrix.set_column(0, [21, 22, 23, 24])
      matrix.set_column(1, [25, 26, 27, 28])
      matrix.set_column(2, [29, 30, 31, 32])
      matrix.set_column(3, [33, 34, 35, 36])

      matrix.get_column(0).should eql [21, 22, 23, 24]      
      matrix.get_column(1).should eql [25, 26, 27, 28]
      matrix.get_column(2).should eql [29, 30, 31, 32]
      matrix.get_column(3).should eql [33, 34, 35, 36]
    end
  end
end
