require_relative("../challenge3/single_byte_xor.rb")

def detect_single_character_xor_from_file filename
  file = File.open(filename, "r")
  file.each_line do |line|
    puts probable_single_byte_xor_key_for_hex_cipher line
  end
end
