require "./matrix.rb"

module Matrix
  class Matrix_128
    def add_round_key(other_matrix_128)
      other_bytes = other_matrix_128.get_bytes
      zipped_pair_bytes = self.get_bytes.zip other_bytes
      result_bytes = zipped_pair_bytes.map do |byte1, byte2|
        byte1 ^ byte2
      end
      self.set_bytes result_bytes
    end
  end
end
