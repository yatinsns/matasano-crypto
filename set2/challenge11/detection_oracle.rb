require_relative "../challenge10/aes_128_cbc.rb"
require_relative "../../set1/challenge7/aes_128_ecb.rb"


module AESRandom
  CIPHERS = ["ecb", "cbc"]
  
  def self.generate_random_key(length)
    generate_random_string(length)
  end

  def self.generate_random_string(length)
    (1..length).map { rand(255).chr }.join
  end

  def self.generate_random_cipher
    CIPHERS[rand(CIPHERS.length)]
  end

  def self.random_int_bw(a, b)
    rand(b - a) + a
  end

  def self.random_padding
    generate_random_string random_int_bw(5, 10)
  end

  def self.random_iv_bytes(length)
    generate_random_string(length).split("").map do |chr|
      chr.ord
    end
  end
end

def encryption_oracle(input)
  padded_input = add_padding_to_text input
  key = AESRandom::generate_random_key 16
  cipher = AESRandom::generate_random_cipher
  puts "Applying cipher: #{cipher}"
  value = case cipher
          when AESRandom::CIPHERS[0] then AES::encrypt_128_ecb(padded_input, key, true)
          when AESRandom::CIPHERS[1] then AES::encrypt_128_cbc(padded_input, key, true, AESRandom::random_iv_bytes(16))
          end
  value
end

def add_padding_to_text(text)
  AESRandom::random_padding + text + AESRandom::random_padding
end

def detect_cipher_from_base64_text(base64_text)
  binary_string = encode_to_binary(decode_from_base64(base64_text))
  binary_128_strings = binary_string.scan(/.{1,128}/)

  duplicates = binary_128_strings.select do |string|
    binary_128_strings.count(string) > 1
  end

  cipher = duplicates.uniq.length > 0 ? AESRandom::CIPHERS[0] : AESRandom::CIPHERS[1]
  puts "Detected cipher: #{cipher}"
  cipher
end

def detect_cipher(cipher)
  input = 'A' * 50
  detect_cipher_from_base64_text cipher.call(input)
end
