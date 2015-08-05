require "../challenge1/conversion.rb"
require "../challenge3/string_additions.rb"

require "./matrix_aes_additions.rb"
require "./matrix_operations.rb"

include Matrix

module AES
  def self.encrypt_128_ecb(message, cipher_key)
    result_binary = message.scan(/.{1,16}/).map do |message_part|
      self.encrypt_128_ecb_partial(message_part, cipher_key)
    end.join
    encode_to_base64(decode_from_binary(result_binary))
  end

  def self.encrypt_128_ecb_partial(message, cipher_key)
    state = Matrix_128.new_with_string(message)
    cipher = Matrix_128.new_with_string(cipher_key)

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

    state.get_bytes.map do |i|
      i.to_s(2).fixed_width_length_with_left_padding(8, "0")
    end.join
  end
end
