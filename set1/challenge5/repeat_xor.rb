require_relative "../challenge3/string_additions.rb"
require_relative "../challenge2/xor.rb"
require_relative "../challenge1/conversion.rb"

def encrypt_string_using_repeat_xor_key(string, xor_key)
  binary_string = encode_to_binary string
  binary_xor_key = encode_to_binary xor_key
  result_binary_string = encrypt_binary_string_using_repeat_xor_binary_key(binary_string, binary_xor_key)
  encode_to_hex(decode_from_binary(result_binary_string))
end

def encrypt_binary_string_using_repeat_xor_binary_key(binary_string, xor_binary_key)
  full_xor_binary_key = xor_binary_key.repeat_for_length binary_string.length
  xor_binary_strings(binary_string, full_xor_binary_key)
end
