require_relative "../shift_row.rb"

describe "Shift row" do
  it "should rotate bytes array" do
    ShiftRow.shift_row([1, 2, 3, 4], 3).should eql [4, 1, 2, 3]
  end
end
