def hex_to_base64(string)
  encode_base64 [string].pack("H*")
end

def encode_base64(string)
  [string].pack("m0")
end

def decode_base64(string)
  string.unpack("m0")
end

