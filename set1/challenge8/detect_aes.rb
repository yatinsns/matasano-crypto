require "../challenge1/conversion.rb"

def detect_aes_from_file(filename)
  File.open(filename).each_line do |line|
    binary_string = encode_to_binary(decode_from_hex(line))
    binary_128_strings = binary_string.scan(/.{1,128}/)

    duplicates = binary_128_strings.select do |string|
      bits_strings.count(string) > 1
    end

    puts line if duplicates.uniq.length > 0
  end
end
