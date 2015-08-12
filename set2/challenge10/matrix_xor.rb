require_relative "../../set1/challenge7/matrix.rb"

module Matrix
  def self.xor(matrix_128_1, matrix_128_2)
    bytes1 = matrix_128_1.get_bytes
    bytes2 = matrix_128_2.get_bytes

    result_bytes = bytes1.zip(bytes2).map do |zipped|
      zipped[0] ^ zipped[1]
    end

    Matrix_128.new result_bytes
  end
end
