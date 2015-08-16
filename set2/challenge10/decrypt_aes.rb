require_relative './aes_128_cbc.rb'
require_relative '../../set1/challenge1/conversion.rb'

def decrypt_file filename
  lines = File.open(filename, "r").each_line.map do |line|
    line.chomp
  end.join

  base64_string = AES::decrypt_128_cbc_base64(lines, "YELLOW SUBMARINE", true)
  decode_from_base64(base64_string)
end
