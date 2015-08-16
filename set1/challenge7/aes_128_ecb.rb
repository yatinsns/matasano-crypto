require "./aes.rb"
require "../../set2/challenge9/pkcs7.rb"

module AES

  # Helper methods

  def self.get_bytes_from_base64(message_base64)
    message_binary = encode_to_binary(decode_from_base64(message_base64))
    message_binary.scan(/.{8}/).map do |byte_string|
      byte_string.to_i 2
    end
  end

  def self.get_base64_from_bytes(message_bytes)
    result_binary = message_bytes.map do |i|
        i.to_s(2).fixed_width_length_with_left_padding(8, "0")
    end.join
    encode_to_base64(decode_from_binary(result_binary))
  end

  # Encryption AES-128-ECB

  def self.encrypt_128_ecb(message, cipher_key, should_pad)
    message = PKCS7::pkcs7_padding_add(message, 16) if should_pad

    result_bytes = message.scan(/.{1,16}/).map do |message_part|
      message_matrix_128 = Matrix_128.new_with_string message_part
      cipher_matrix_128 = Matrix_128.new_with_string cipher_key
      encrypt_128_ecb_block(message_matrix_128, cipher_matrix_128).get_bytes
    end.flatten

    get_base64_from_bytes result_bytes
  end

  def self.encrypt_128_ecb_block(message_matrix_128, cipher_matrix_128)
    block_cipher_encryption(message_matrix_128, cipher_matrix_128)
  end

  # Decryption AES-128-ECB

  def self.decrypt_128_ecb_base64(message_base64, cipher_key, is_padded)
    bytes = get_bytes_from_base64 message_base64
    result_bytes = decrypt_128_ecb_bytes(bytes, cipher_key)
    result_bytes = PKCS7::pkcs7_padding_remove_bytes(result_bytes) if is_padded
    get_base64_from_bytes result_bytes
  end

   def self.decrypt_128_ecb_bytes(message_bytes, cipher_key)
    message_bytes.each_slice(16).map do |slice|
      bytes = slice.fill(0, slice.length...16)
      message_matrix_128 = Matrix_128.new bytes
      cipher_matrix_128 = Matrix_128.new_with_string cipher_key

      decrypt_128_ecb_block(message_matrix_128, cipher_matrix_128).get_bytes
    end.flatten
  end

  def self.decrypt_128_ecb_block(message_matrix_128, cipher_matrix_128)
    block_cipher_decryption(message_matrix_128, cipher_matrix_128)
  end
end
