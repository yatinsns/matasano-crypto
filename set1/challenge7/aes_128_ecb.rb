require_relative "./aes.rb"
require_relative "../../set2/challenge9/pkcs7.rb"
require_relative "./conversion_helper.rb"

module AES
  
  # Encryption AES-128-ECB

  def self.encrypt_128_ecb(message, cipher_key, should_pad)
    message = PKCS7::pkcs7_padding_add(message, 16) if should_pad
    message_chunks = message.chars.each_slice(16).map(&:join)

    result_bytes = message_chunks.map do |message_part|
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
