require_relative "../challenge2/xor.rb"
require_relative "./string_additions.rb"

def new_binary_key_from_i(key)
  key.to_s(2).fixed_width_length_with_left_padding(8, "0")
end

def probable_single_byte_xor_key_for_hex_cipher(hex_cipher)
  binary_cipher = encode_to_binary(decode_from_hex(hex_cipher))
  probable_single_byte_xor_key_for_binary_cipher binary_cipher
end

def probable_single_byte_xor_key_for_binary_cipher(binary_cipher)
  (0..255).inject(Hash.new) do |result, probable_key|
    formatted_key = new_binary_key_from_i(probable_key)
    full_key = formatted_key.repeat_for_length binary_cipher.length
    
    result_binary_string = xor_binary_strings(binary_cipher, full_key)
    result_string = decode_from_binary result_binary_string

    current_count = result_string.scan(/[ETAOIN SHRDLU]/i).size
    result = {
      :key => formatted_key,
      :count => current_count,
      :result => result_string
    } if result[:count] == NIL || result[:count] < current_count
    
    result
  end
end
