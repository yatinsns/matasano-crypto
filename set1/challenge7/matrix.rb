module Matrix
  class Matrix_128
    ROW_COUNT = 4
    COLUMN_COUNT = 4

    def initialize(bytes)
      raise "Incorrect count of bytes for matrix_128" unless bytes.length == (ROW_COUNT * COLUMN_COUNT)
      
      # Need to convert bytes columnwise for 4X4 matrix
      @bytes = ROW_COUNT.times.map do |row|
        COLUMN_COUNT.times.map do |col|
          bytes[col * ROW_COUNT + row]
        end
      end
    end

    def get_bytes
      COLUMN_COUNT.times.inject(Array.new) do |result, col|
        get_column(col).each {|byte| result.push byte}
        result
      end
    end

    def get_row(number)
      raise "Incorrect row" unless number < ROW_COUNT
      @bytes[number]  
    end

    def get_column(number)
      raise "Incorrect column" unless number < COLUMN_COUNT
      @bytes.map {|row| row[number]}
    end

    def set_row(number, bytes)
      raise "Incorrect new row count" unless bytes.length == COLUMN_COUNT
      raise "Incorrect row" unless number < ROW_COUNT

      @bytes[number] = bytes
    end

    def set_column(number, bytes)
      raise "Incorrect new column count" unless bytes.length == ROW_COUNT
      raise "Incorrect column" unless number < COLUMN_COUNT

      ROW_COUNT.times do |row|
        @bytes[row][number] = bytes[row]
      end
    end
  end
end
