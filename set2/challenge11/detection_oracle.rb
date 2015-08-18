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
end

def encryption_oracle(input)
  padded_input = add_padding_to_text input
  key = AESRandom::generate_random_key 16
  case AESRandom::generate_random_cipher
  when "ebc" then AES::encrypt_128_ecb(padded_input, key, true)
  when "cbc" then AES::encrypt_128_cbc(padded_input, key, true)
  end
end

def add_padding_to_text(text)
  AESRandom::random_padding + "text" + AESRandom::random_padding
end
