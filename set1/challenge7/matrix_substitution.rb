require "./matrix.rb"
require "./substitution.rb"

module Matrix
  def self.get_matrix_128_after_substitution(matrix_128)
    substituted_bytes = matrix_128.get_bytes.map do |byte|
      Substitution.sub_byte byte
    end
    Matrix_128.new(substituted_bytes)
  end
end

