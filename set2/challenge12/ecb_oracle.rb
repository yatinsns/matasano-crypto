#!/usr/bin/env ruby

require_relative "../../set1/challenge1/conversion.rb"
require_relative "../../set1/challenge7/aes_128_ecb.rb"
require_relative "../../set2/challenge11/detection_oracle.rb"
require_relative "../../set2/challenge9/pkcs7.rb"

$key = ""

def add_suffix(string)
  unknown_base64 = "Um9sbGluJyBpbiBteSA1LjAKV2l0aCBteSByYWctdG9wIGRvd24gc28gbXkgaGFpciBjYW4gYmxvdwpUaGUgZ2lybGllcyBvbiBzdGFuZGJ5IHdhdmluZyBqdXN0IHRvIHNheSBoaQpEaWQgeW91IHN0b3A/IE5vLCBJIGp1c3QgZHJvdmUgYnkK"
  string + decode_from_base64(unknown_base64)
end

def ecb_oracle(string)
  block_size = 16
  $key ||= AESRandom::generate_random_key block_size
  AES::encrypt_128_ecb(add_suffix(string), $key, true)
end

def get_block_from_base64(base64_string, block_number, block_size)
  decode_from_base64(base64_string).slice((block_number - 1) * block_size,
                                          block_size)
end

def hack_ecb_oracle_length
  decode_from_base64(ecb_oracle "").length
end

def is_ecb_detected?(string, block_size)
  strings = string.chars.each_slice(block_size).map(&:join)
  strings[0] == strings[1]
end

def hack_ecb_oracle_block_size
  max_block_size = hack_ecb_oracle_length
  (1..max_block_size).find do |block_size|
    string = "AA" * block_size 
    result_base64 = ecb_oracle string
    is_ecb_detected?(decode_from_base64(result_base64), block_size)
  end
end

def hack_ecb_oracle
  # FIXME: It takes apx 25 minutes to pass test :(. Some blunder.
  block_size = hack_ecb_oracle_block_size
  output_length = hack_ecb_oracle_length

  done = false
  (1..output_length).inject("") do |output, output_byte_number|
    unless done
      block_number = (Float(output_byte_number) / block_size).ceil
      prefix_length = block_number * block_size - output_byte_number
      prefix = "A" * prefix_length

      result_base64 = ecb_oracle prefix
      result_block = get_block_from_base64(result_base64, block_number, block_size)

      output_byte = (0..255).find do |byte|
        temp_base64 = ecb_oracle(prefix + output + byte.chr)
        temp_block = get_block_from_base64(temp_base64, block_number, block_size)
        result_block == temp_block
      end

      unless output_byte.nil?
        output = output + output_byte.chr
        puts output
      else
        done = true
      end
    end

    output
  end
end

