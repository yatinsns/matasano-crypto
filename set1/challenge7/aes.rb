require "../challenge1/conversion.rb"
require "../challenge3/string_additions.rb"

require "./matrix_aes_additions.rb"
require "./matrix_add_round_key.rb"
require "./matrix_shift_rows.rb"
require "./matrix_substitution.rb"
require "./matrix_mix_columns.rb"
require "./matrix_key_generation.rb"

include Matrix

module AES
  def self.encrypt_128_ecb(message, cipher_key)
    # Suppose message be of length 16 bytes only for now.
    state = Matrix_128.new_with_128_bits_string(message)
    cipher = Matrix_128.new_with_128_bits_string(cipher_key)

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
