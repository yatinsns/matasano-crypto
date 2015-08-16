require "./aes.rb"
require "../../set2/challenge9/pkcs7.rb"

module AES
  def self.encrypt_128_ecb(message, cipher_key, should_pad)
    message = PKCS7::pkcs7_padding_add(message, 16) if should_pad
    result_binary = message.scan(/.{1,16}/).map do |message_part|
      self.encrypt_128_ecb_partial(message_part, cipher_key)
    end.join

    encode_to_base64(decode_from_binary(result_binary))
  end

  def self.encrypt_128_ecb_partial(message, cipher_key)
    state_matrix_128 = Matrix_128.new_with_string(message)
    cipher_matrix_128 = Matrix_128.new_with_string(cipher_key)

    result_matrix_128 = block_cipher_encryption(state_matrix_128,
                                                cipher_matrix_128)
    result_matrix_128.get_bytes.map do |i|
      i.to_s(2).fixed_width_length_with_left_padding(8, "0")
    end.join
  end

  def self.decrypt_128_ecb(message_base64, cipher_key, is_padded)
    binary_string = encode_to_binary(decode_from_base64(message_base64))
    bytes = binary_string.scan(/.{8}/).map do |byte_string|
      byte_string.to_i 2
    end
    
    result_bytes = bytes.each_slice(16).map do |sliced_bytes|
      self.decrypt_128_ecb_partial(sliced_bytes, cipher_key)
    end.flatten

    result_bytes = PKCS7::pkcs7_padding_remove_bytes(result_bytes) if is_padded

    result_binary = result_bytes.map do |i|
      i.to_s(2).fixed_width_length_with_left_padding(8, "0")
    end.join

    encode_to_base64(decode_from_binary(result_binary))
  end

  def self.decrypt_128_ecb_partial(message_bytes, cipher_key)
    state_matrix_128 = Matrix_128.new(message_bytes)
    cipher_matrix_128 = Matrix_128.new_with_string(cipher_key)

    result_matrix_128 = block_cipher_decryption(state_matrix_128,
                                                cipher_matrix_128)
    result_matrix_128.get_bytes
  end
end
