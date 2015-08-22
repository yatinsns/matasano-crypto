#!/usr/bin/env ruby

require_relative "../../set1/challenge1/conversion.rb"
require_relative "../../set1/challenge7/aes_128_ecb.rb"
require_relative "../../set2/challenge11/detection_oracle.rb"
require_relative "../../set2/challenge9/pkcs7.rb"

def add_suffix(string)
  suffix_base64 = "Um9sbGluJyBpbiBteSA1LjAKV2l0aCBteSByYWctdG9wIGRvd24gc28gbXkgaGFpciBjYW4gYmxvdwpUaGUgZ2lybGllcyBvbiBzdGFuZGJ5IHdhdmluZyBqdXN0IHRvIHNheSBoaQpEaWQgeW91IHN0b3A/IE5vLCBJIGp1c3QgZHJvdmUgYnkK"
  string + decode_from_base64(suffix_base64)
end

def ecb_oracle(string, key)
  AES::encrypt_128_ecb(add_suffix(string), key, true)
end

def get_block_from_base64(base64_string, block_number, block_size)
  decode_from_base64(base64_string).slice((block_number - 1) * block_size,
                                          block_size)
end

def hack_ecb_oracle_length block_size
  key = AESRandom::generate_random_key block_size
  decode_from_base64(ecb_oracle("", key)).length
end

def hack_ecb_oracle
  # Need to confirm?
  block_size = 16

  # Need to confirm if it is ecb?

  # Hack it
  key = AESRandom::generate_random_key block_size
  output_length = hack_ecb_oracle_length block_size

  (1..output_length).inject("") do |output, output_byte_number|
    block_number = (Float(output_byte_number) / block_size).ceil
    prefix_length = block_number * block_size - output_byte_number
    prefix = "A" * prefix_length

    result_base64 = ecb_oracle(prefix, key)
    result_block = get_block_from_base64(result_base64, block_number, block_size)

    output_byte = (0..255).find do |byte|
      temp_base64 = ecb_oracle(prefix + output + byte.chr, key)
      temp_block = get_block_from_base64(temp_base64, block_number, block_size)
      result_block == temp_block
    end

    output = output + output_byte.chr
    puts output
    output
  end
end

