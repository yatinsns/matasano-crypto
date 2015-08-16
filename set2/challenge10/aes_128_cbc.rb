require_relative "../../set1/challenge7/aes.rb"
require_relative "./matrix_xor.rb"
require_relative "../challenge9/pkcs7.rb"

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

  def self.initialization_matrix_128
    Matrix_128.new_with_string("".ljust(16, 0.chr))
  end

  # Encryption AES-128-CBC
  
  def self.encrypt_128_cbc(message, cipher_key)
    padded_message = pkcs7_padding_add(message, 16)
    vector_matrix_128 = initialization_matrix_128
    result_bytes = padded_message.scan(/.{1,16}/).map do |message_part|
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

  def self.decrypt_128_cbc_base64(message_base64, cipher_key)
    bytes = get_bytes_from_base64 message_base64
    result_bytes = decrypt_128_cbc_bytes(bytes, cipher_key)
    get_base64_from_bytes PKCS7::pkcs7_padding_remove_bytes(result_bytes)
  end

  def self.decrypt_128_cbc_bytes(message_bytes, cipher_key)
    vector_matrix_128 = initialization_matrix_128
    
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
