require_relative "../challenge1/conversion.rb"

def xor_hex_strings(hex_string_first, hex_string_second)
  binary_string_first = encode_to_binary(decode_from_hex(hex_string_first))
  binary_string_second = encode_to_binary(decode_from_hex(hex_string_second))

  xor_binary_strings(binary_string_first, binary_string_second)
end

def xor_binary_strings(binary_string_first, binary_string_second)
  zipped_binary_array = binary_string_first.split('').zip binary_string_second.split('')
  result_binary_string = zipped_binary_array.map do |chr1, chr2|
    (chr1.to_i ^ chr2.to_i).to_s
  end.join
  
  encode_to_hex(decode_from_binary(result_binary_string))
end
