require "./matrix.rb"

module Matrix
  class Matrix_128
    def self.new_with_string(string)
      raise "length of string is not 16" unless string.length == 16

      bytes = encode_to_binary(string).scan(/.{8}/).map do |str|
        str.to_i 2
      end
      self.new(bytes)
    end
  end
end
