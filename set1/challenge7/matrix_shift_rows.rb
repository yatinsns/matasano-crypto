require "./matrix.rb"
require "./shift_row.rb"

module Matrix
  class Matrix_128
    def shift_row
      ROW_COUNT.times.each do |row_number|
        shifted_row = ShiftRow.shift_row(self.get_row(row_number), row_number)
        self.set_row(row_number, shifted_row) 
      end
    end

    def inverse_shift_row
      ROW_COUNT.times.each do |row_number|
        count = row_number == 0 ? 0 : (ROW_COUNT - row_number)
        shifted_row = ShiftRow.shift_row(self.get_row(row_number), count)
        self.set_row(row_number, shifted_row)
      end
    end
  end
end 
