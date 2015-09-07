#!/usr/bin/env ruby
require_relative "../challenge11/detection_oracle.rb"

def profile(email)
  return "email=#{email}&uid=#{rand 100}&role=user"
end

def oracle(email)
  $key ||= AESRandom::generate_random_key 16
  AES::encrypt_128_ecb(profile(email), $key, true)
end

def decrypt(message_base64)
  decode_from_base64 AES::decrypt_128_ecb_base64(message_base64, $key, true)
end
