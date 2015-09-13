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

def add_prefix(string)
  if $prefix.nil?
    $prefix ||= AESRandom::generate_random_string(rand 100)
    puts "prefix: #{$prefix.length}"
  end  
  $prefix + string
end

def ecb_oracle(string)
  block_size = 16
  $key ||= AESRandom::generate_random_key block_size
  AES::encrypt_128_ecb(add_prefix(add_suffix(string)), $key, true)
end

def get_block_from_base64(base64_string, block_number, block_size)
  decode_from_base64(base64_string).slice((block_number - 1) * block_size,
                                          block_size)
end

def hack_ecb_oracle_length
  decode_from_base64(ecb_oracle "").length
end

def is_ecb_detected?(string, block_size)
  blocks = string.chars.each_slice(block_size).map(&:join)
  duplicate_blocks = blocks.select do |block|
    blocks.count(block) > 1
  end
  duplicate_blocks.uniq.length > 0
end

def hack_ecb_oracle_block_size
  max_block_size = hack_ecb_oracle_length
  (8..max_block_size).find do |block_size|
    string = "AA" * block_size
    possible_prefix_length = nil
    possible_prefix_length = (0...block_size).find do |prefix_length|
      new_string = ("A" * prefix_length) + string
      result_base64 = ecb_oracle new_string
      is_ecb_detected?(decode_from_base64(result_base64), block_size)
    end
    !possible_prefix_length.nil?
  end
end

def hack_ecb_oracle_prefix_length(block_size)
  double_block_size = block_size * 2
  triple_block_size = block_size * 3
  
  string_length = (double_block_size..triple_block_size).find do |length|
    cipher_text_base64 = ecb_oracle("A" * length)
    cipher_text = decode_from_base64(cipher_text_base64)
    is_ecb_detected?(cipher_text, block_size)
  end

  cipher_text = decode_from_base64 ecb_oracle("A" * string_length)
  cipher_text_blocks = cipher_text.chars.each_slice(16).map(&:join)
  string_start_index = (0...cipher_text_blocks.length).find do |index|
    cipher_text_blocks.count(cipher_text_blocks[index]) > 1
  end

  gap = string_length - double_block_size
  (string_start_index * block_size) - gap
end

def hack_ecb_oracle
  block_size = hack_ecb_oracle_block_size
  prefix_length = hack_ecb_oracle_prefix_length block_size
  prefix_blocks_count = (Float(prefix_length) / block_size).ceil
  output_length = hack_ecb_oracle_length

  puts "block_size: #{block_size}"
  puts "prefix_length: #{prefix_length}"
  puts "prefix_blocks_count: #{prefix_blocks_count}"
  done = false
  result = (1..output_length).inject("") do |output, output_byte_number|
    unless done
      block_number = prefix_blocks_count + (Float(output_byte_number) / block_size).ceil
      string_length = (block_number - prefix_blocks_count) * block_size - output_byte_number
      string = "A" * ((prefix_blocks_count * block_size) - prefix_length + string_length)

      result_base64 = ecb_oracle string
      result_block = get_block_from_base64(result_base64, block_number, block_size)

      output_byte = (0..255).find do |byte|
        temp_base64 = ecb_oracle(string + output + byte.chr)
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
  PKCS7::pkcs7_padding_remove result
end

