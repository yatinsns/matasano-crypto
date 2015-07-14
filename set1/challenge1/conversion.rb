def hex_to_base64(hex_string)
  encode_to_base64(decode_from_hex(hex_string)) 
end

# base64
def encode_to_base64(string)
  [string].pack("m0")
end

def decode_from_base64(base64_string)
  base64_string.unpack("m0").first
end

# hexadecimal
def encode_to_hex(string)
  string.unpack("H*").first
end

def decode_from_hex(hex_string)
  [hex_string].pack("H*")
end

# binary
def encode_to_binary(string)
  string.unpack("B*").first
end

def decode_from_binary(binary_string)
  [binary_string].pack("B*")
end

