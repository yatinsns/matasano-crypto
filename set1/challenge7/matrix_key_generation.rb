require "./matrix.rb"
require "./substitution.rb"
require "./mix_columns.rb"

module Matrix
  class Matrix_128
    ROUNDS_COUNT = 10

    def get_rot_word_bytes
      rot_word = self.get_column(COLUMN_COUNT - 1).rotate(1).map do |byte|
        Substitution.sub_byte byte
      end
      result = rot_word.zip(@rcon).map do |byte1, byte2|
        byte1 ^ byte2
      end
      result
    end

    def generate_next
      @rcon = case @rcon
        when nil then [1, 0, 0, 0]
        else [MixColumns.mult_2(@rcon[0]), 0, 0, 0]
      end

      rot_word_bytes = self.get_rot_word_bytes
      
      COLUMN_COUNT.times do |col_number|
        col = self.get_column col_number
        rot_word_bytes = rot_word_bytes.zip(col).map do |byte1, byte2|
          byte1 ^ byte2
        end
        self.set_column(col_number, rot_word_bytes)
      end

      self
    end
  end
end
