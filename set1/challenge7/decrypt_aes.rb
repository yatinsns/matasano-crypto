require './aes.rb'
require '../challenge1/conversion.rb'

def decrypt_file filename
  lines = File.open(filename, "r").each_line.map do |line|
    line.chomp
  end.join
  
  base64_string = AES::decrypt_128_ecb(lines, "YELLOW SUBMARINE")
  decode_from_base64(base64_string)
end
