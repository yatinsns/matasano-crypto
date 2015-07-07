require_relative "../challenge2/xor.rb"

def new_hex(key)
  hex_value = key.to_s 16
  hex_value = "0" + hex_value unless hex_value.length == 2
  hex_value
end

def repeat_xor_key_for_length(key, length)
  Array.new((length / key.length) + 1, key).join.slice(0, length)
end

def print_probable_single_byte_xor_keys_for_cipher(cipher)
  (0..255).each do |probable_key|
    formatted_key = new_hex(probable_key)
    full_key = repeat_xor_key_for_length(formatted_key, cipher.length)
    
    result = [xor(cipher, full_key)].pack("H*")
    count = result.scan(/[ETAOIN SHRDLU]/i).size

    if count > 20
      puts "key : 0x#{probable_key.to_s 16} with count: #{count}"
      puts "Encrypted key: #{cipher}"
      puts "Decrypted key: #{result}"
    end
  end
end
