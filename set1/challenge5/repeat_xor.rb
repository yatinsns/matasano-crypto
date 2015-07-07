require_relative "../challenge3/single_byte_xor.rb"

def encrypt_string_using_repeat_xor_key(string, xor_key_string)
  full_xor_key_string = repeat_xor_key_for_length(xor_key_string, string.length)
  xor(string.unpack("H*").first, full_xor_key_string.unpack("H*").first)
end
