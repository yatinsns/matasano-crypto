require "../challenge1/conversion.rb"
require "../challenge3/string_additions.rb"

require "./matrix.rb"
require "./matrix_add_round_key.rb"
require "./matrix_shift_rows.rb"
require "./matrix_substitution.rb"
require "./matrix_mix_columns.rb"
require "./matrix_key_generation.rb"

include Matrix

module AES
  def self.encrypt_128_ecb(message, cipher_key)
    # Suppose message be of length 16 bytes only for now.
    message_bytes = encode_to_binary(message).scan(/.{8}/).map do |str|
      str.to_i 2
    end
    puts message_bytes.length
    state = Matrix_128.new(message_bytes)

    cipher_bytes = encode_to_binary(cipher_key).scan(/.{8}/).map do |str|
      str.to_i 2
    end
    cipher = Matrix_128.new(cipher_bytes)

    # begin
    state.add_round_key cipher

    # middle
    9.times do |turn|
      state.substitute
      state.shift_row
      state.mix_columns
      state.add_round_key cipher.generate_next
    end

    # end
    state.substitute
    state.shift_row
    state.add_round_key cipher.generate_next

    encode_to_base64(decode_from_binary(state.get_bytes.map do |i|
      i.to_s(2).fixed_width_length_with_left_padding(8, "0")
    end.join))
  end
end
