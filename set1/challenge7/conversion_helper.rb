require_relative "../challenge1/conversion.rb"

def get_bytes_from_base64(message_base64)
  message_binary = encode_to_binary(decode_from_base64(message_base64))
  message_binary.scan(/.{8}/).map do |byte_string|
    byte_string.to_i 2
  end
end

def get_base64_from_bytes(message_bytes)
  result_binary = message_bytes.map do |i|
    i.to_s(2).fixed_width_length_with_left_padding(8, "0")
  end.join
  encode_to_base64(decode_from_binary(result_binary))
end
