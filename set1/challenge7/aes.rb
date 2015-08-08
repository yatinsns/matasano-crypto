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

    round_ciphers = cipher.get_round_ciphers

    # begin
    round = 0
    state.add_round_key round_ciphers[round]

    # middle
    9.times do |turn|
      round += 1
      state.substitute
      state.shift_row
      state.mix_columns
      state.add_round_key round_ciphers[round]
    end

    # end
    round += 1
    state.substitute
    state.shift_row
    state.add_round_key round_ciphers[round]

    state.get_bytes.map do |i|
      i.to_s(2).fixed_width_length_with_left_padding(8, "0")
    end.join
  end

  def self.decrypt_128_ecb(message_base64, cipher_key)
    bytes = encode_to_binary(decode_from_base64(message_base64)).scan(/.{8}/).map do |byte_string|
      byte_string.to_i 2
    end

    result_binary = bytes.each_slice(16).map do |slice|
      message = slice.map do |num|
        num.chr
      end.join
      self.decrypt_128_ecb_partial(message, cipher_key)
    end.join

    encode_to_base64(decode_from_binary(result_binary))
  end

  def self.decrypt_128_ecb_partial(message, cipher_key)
    state = Matrix_128.new_with_string(message)
    cipher = Matrix_128.new_with_string(cipher_key)

    round_ciphers = cipher.get_round_ciphers

    # begin
    round = 10
    state.add_round_key round_ciphers[round]

    # middle
    9.times do |turn|
      round -= 1

      state.inverse_shift_row
      state.inverse_substitute
      state.add_round_key round_ciphers[round]
      state.inverse_mix_columns
    end

    # end
    round -= 1
    state.inverse_shift_row
    state.inverse_substitute
    state.add_round_key round_ciphers[round]

    state.get_bytes.map do |i|
      i.to_s(2).fixed_width_length_with_left_padding(8, "0")
    end.join
  end
end
