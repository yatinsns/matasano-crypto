require_relative "../../set1/challenge7/aes.rb"
require_relative "./matrix_xor.rb"
require_relative "../challenge9/pkcs7.rb"
require_relative "../../set1/challenge7/conversion_helper.rb"

module AES
  DEFAULT_INIT_BYTES = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

  # Encryption AES-128-CBC
  
  def self.encrypt_128_cbc(message, cipher_key, should_pad, init_16_bytes=DEFAULT_INIT_BYTES)
    message = PKCS7::pkcs7_padding_add(message, 16) if should_pad
    vector_matrix_128 = Matrix_128.new init_16_bytes
    result_bytes = message.scan(/.{1,16}/).map do |message_part|
      message_matrix_128 = Matrix_128.new_with_string message_part
      cipher_matrix_128 = Matrix_128.new_with_string cipher_key
      
      vector_matrix_128 = encrypt_128_cbc_block(message_matrix_128,
                                                cipher_matrix_128,
                                                vector_matrix_128)
      vector_matrix_128.get_bytes
    end.flatten

    get_base64_from_bytes result_bytes
  end

  def self.encrypt_128_cbc_block(message_matrix_128,
                                 cipher_matrix_128,
                                 vector_matrix_128)
    result_matrix_128 = Matrix::xor(message_matrix_128, vector_matrix_128)
    block_cipher_encryption(result_matrix_128, cipher_matrix_128)
  end

  # Decryption AES-128-CBC

  def self.decrypt_128_cbc_base64(message_base64, cipher_key, is_padded, init_16_bytes=DEFAULT_INIT_BYTES)
    bytes = get_bytes_from_base64 message_base64
    result_bytes = decrypt_128_cbc_bytes(bytes, cipher_key, init_16_bytes)
    result_bytes = PKCS7::pkcs7_padding_remove_bytes(result_bytes) if is_padded
    get_base64_from_bytes result_bytes
  end

  def self.decrypt_128_cbc_bytes(message_bytes, cipher_key, init_16_bytes)
    vector_matrix_128 = Matrix_128.new init_16_bytes
    
    message_bytes.each_slice(16).map do |slice|
      bytes = slice.fill(0, slice.length...16)
      message_matrix_128 = Matrix_128.new bytes
      cipher_matrix_128 = Matrix_128.new_with_string cipher_key

      result_matrix_128 = decrypt_128_cbc_block(message_matrix_128,
                                                cipher_matrix_128,
                                                vector_matrix_128)
      vector_matrix_128 = Matrix_128.new bytes
      result_matrix_128.get_bytes
    end.flatten
  end

  def self.decrypt_128_cbc_block(message_matrix_128,
                                 cipher_matrix_128,
                                 vector_matrix_128)
    result_matrix = block_cipher_decryption(message_matrix_128, cipher_matrix_128)
    Matrix::xor(result_matrix, vector_matrix_128)
  end
end
