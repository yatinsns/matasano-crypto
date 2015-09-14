#!/usr/bin/env ruby

module PKCS7
  def self.pkcs7_padding_remove_with_exception(message)
    bytes = message.each_char.map {|chr| chr.ord}
    result = nil
    
    if pkcs7_padding_is_valid_bytes(bytes)
      result = pkcs7_padding_remove_bytes(bytes).map do |byte|
        byte.chr
      end.join
    else
      raise "Invalid PKCS7 padding"
    end
    result
  end

  def self.pkcs7_padding_is_valid_bytes(message_bytes)
    padding_length = message_bytes[-1]
    reverse_bytes = message_bytes.reverse
    is_valid = true
    (0...padding_length).each do |index|
      is_valid = false if reverse_bytes[index] != padding_length
    end
    is_valid
  end

  def self.pkcs7_padding_remove_bytes(message_bytes)
    padding_length = message_bytes[message_bytes.length - 1]
    message_bytes[0...(message_bytes.length - padding_length)]
  end
end
