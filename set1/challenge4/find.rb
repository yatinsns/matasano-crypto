require_relative("../challenge3/single_byte_xor.rb")

def detect_single_character_xor_from_file filename
  file = File.open(filename, "r")
  file.each_line do |line|
    print_probable_single_byte_xor_keys_for_cipher line
  end
end
