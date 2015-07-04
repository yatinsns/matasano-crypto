def xor(hex_string_first, hex_string_second)
  characters_array_first = characters_array_for_hex_string hex_string_first
  characters_array_second = characters_array_for_hex_string hex_string_second

  zipped_characters_array = characters_array_first.zip characters_array_second
  xored_hex_array = zipped_characters_array.map do |pair|
    (pair[0] ^ pair[1]).to_s 16
  end
  xored_hex_array.join
end

def characters_array_for_hex_string hex_string
  [hex_string].pack("H*").unpack("C*")
end
