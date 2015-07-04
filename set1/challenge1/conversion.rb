def hex_to_base64(string)
  [[string].pack("H*")].pack("m").strip
end

