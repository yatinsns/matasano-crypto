#!/usr/bin/env ruby
require_relative "../challenge11/detection_oracle.rb"

def profile(email)
  return "email=#{email}&uid=#{rand 10}&role=user"
end

def oracle(email)
  $key ||= AESRandom::generate_random_key 16
  AES::encrypt_128_ecb(profile(email), $key, true)
end

def decrypt(message_base64)
  decode_from_base64 AES::decrypt_128_ecb_base64(message_base64, $key, true)
end

def hack_role_in_oracle_for_email
  email_length = 11
  result_encoding = ""
  user_cipher_block = get_user_cipher_block

  while email_length < 27
    email = get_random_email_of_length email_length
    cipher_blocks = get_all_cipher_blocks_for_email email

    number_of_blocks = cipher_blocks.length
    if cipher_blocks[number_of_blocks - 1].eql? user_cipher_block
      cipher_blocks[number_of_blocks - 1] = get_admin_cipher_block
      result_encoding = decrypt_cipher_blocks cipher_blocks
      break
    end
    email_length += 1
  end

  result_encoding
end

def decrypt_cipher_blocks cipher_blocks
  result_cipher_text = cipher_blocks.join
  result_cipher_text_base64 = encode_to_base64 result_cipher_text
  decrypt(result_cipher_text_base64)
end

def get_user_cipher_block
  user_block_text = get_string_for_block_size "user"
  get_cipher_block_for_string user_block_text
end

def get_admin_cipher_block
  admin_block_text = get_string_for_block_size "admin"
  get_cipher_block_for_string admin_block_text
end

def get_all_cipher_blocks_for_email email
  cipher_text_base64 = oracle email
  cipher_text = decode_from_base64 cipher_text_base64
  cipher_text.chars.each_slice(16).map(&:join)
end

def get_cipher_block_for_string(string)
  cipher_text_base64 = oracle("yatins@ab." + string + "com")
  cipher_text = decode_from_base64 cipher_text_base64
  cipher_text_blocks = cipher_text.chars.each_slice(16).map(&:join)
  cipher_text_blocks[1]
end

def get_string_for_block_size(string)
  padding_length = 16 - string.length
  string + Array.new(padding_length, padding_length.chr).join
end

def get_random_email_of_length(length)
  possible_chars = ('A'..'Z').to_a + (0..9).to_a
  (0...length).map {possible_chars.sample}.join
end
