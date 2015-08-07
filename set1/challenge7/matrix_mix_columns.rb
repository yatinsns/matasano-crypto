require "./matrix.rb"
require "./mix_columns.rb"
require "./mix_columns_constants.rb"

module Matrix
  class Matrix_128
    def mix_columns
      new_rows = self.multiply MixColumns.mix_columns_matrix_128

      ROW_COUNT.times do |row_number|
        self.set_row(row_number, new_rows[row_number])
      end
    end

    def inverse_mix_columns
      new_rows = self.multiply MixColumns.inverse_mix_columns_matrix_128 

      ROW_COUNT.times do |row_number|
        self.set_row(row_number, new_rows[row_number])
      end
    end

    def multiply(mix_column_matrix_128)
      ROW_COUNT.times.map do |row_number|
        row = mix_column_matrix_128.get_row row_number
        COLUMN_COUNT.times.map do |col_number|
          column = self.get_column col_number
          row.zip(column).reduce(0) do |result, bytes|
            mult = case bytes[0]
              when 1 then bytes[1]
              when 2 then MixColumns.mult_2 bytes[1]
              when 3 then MixColumns.mult_3 bytes[1]
              when 9 then MixColumns.mult_9 bytes[1]
              when 11 then MixColumns.mult_11 bytes[1]
              when 13 then MixColumns.mult_13 bytes[1]
              when 14 then MixColumns.mult_14 bytes[1]
              else raise "Unexpected multiplication byte"
            end
            result ^ mult
          end
        end
      end
    end
  end
end
