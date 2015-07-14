require_relative "../challenge3/single_byte_xor.rb"
require_relative "../challenge5/repeat_xor.rb"

def hamming_distance_between_strings(string1, string2)
  binary_string1 = encode_to_binary string1
  binary_string2 = encode_to_binary string2
  hamming_distance_between_binary_strings(binary_string1, binary_string2)
end

def hamming_distance_between_binary_strings(binary_string1, binary_string2)
  binary_array1 = binary_string1.split('')
  binary_array2 = binary_string2.split('')
  zipped_array = binary_array1.zip binary_array2
  zipped_array.select {|pair| pair[0] != pair[1]}.length
end

def get_contents_from_file_with_name filename
  file = File.open(filename, "r")
  contents = file.read.chomp
  file.close
  contents
end

def base64_to_binary(string)
  encode_to_binary(decode_from_base64(string))
end

def get_normalized_weights_info_for_keysize_in_range(binary_string, start_keysize, end_keysize)
  weights_info = {}
  (start_keysize..end_keysize).each do |keysize|
    number_of_bits = keysize * 8
    count = 0
    total_hd = (0...binary_string.length).step(number_of_bits).reduce do |result, index|
      hd = 0
      if (index + 2 * number_of_bits < binary_string.length)
        slice1 = binary_string.slice(index, number_of_bits)
        slice2 = binary_string.slice(index + number_of_bits, number_of_bits)
        hd = hamming_distance_between_binary_strings(slice1, slice2).to_f
        count += 1
      end
      result + hd
    end
    weight = (total_hd / count) / keysize
    weights_info[keysize] = weight
    puts "keysize: #{keysize} hamming_distance: #{total_hd} count: #{count}"
    puts ""
  end
  weights_info
end

def decrypt_binary_string_with_keysize(binary_string, keysize)
  keysize.times.map do |turn|
    block = ((0 + turn * 8)...binary_string.length).step(keysize * 8).map do |index|
      binary_string.slice(index, 8)
    end
    probable_single_byte_xor_key_for_binary_cipher(block.join)[:key]
  end.join
end

def decrypt_file_with_name(filename)
  base64_string = get_contents_from_file_with_name filename
  binary_string = base64_to_binary base64_string

  weights_info = get_normalized_weights_info_for_keysize_in_range(binary_string, 2, 40)
  sorted_weights_info = weights_info.sort_by {|keysize, weight| weight}
  
  probable_keysize = sorted_weights_info[0][0]
  puts "Probable keysize: #{probable_keysize}"

  xor_binary_key =  decrypt_binary_string_with_keysize(binary_string, probable_keysize)
  result_binary_string = encrypt_binary_string_using_repeat_xor_binary_key(binary_string, xor_binary_key)
  puts decode_from_binary(result_binary_string)
=begin
  (0...binary_string.length).step(probable_keysize * 8).each do |index|
    bs = [binary_string.slice(index, probable_keysize * 8)].pack("B*").unpack("H*").first
    puts [xor(bs, xor_key)].pack("H*")
  end
=end
end
