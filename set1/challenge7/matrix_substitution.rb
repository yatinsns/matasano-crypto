require "./matrix.rb"
require "./substitution.rb"

module Matrix
  def self.get_matrix_128_after_substitution(matrix_128)
    matrix_128.set_bytes(matrix_128.get_bytes.map do |byte|
      Substitution.sub_byte byte
    end)
    matrix_128
  end
end

