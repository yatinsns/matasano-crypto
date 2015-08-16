
module PKCS7
  def self.pkcs7_padding_add(message, block_size)
    padding_length = block_size - (message.length % block_size)
    message.ljust(message.length + padding_length,
                  padding_length.chr)
  end

  def self.pkcs7_padding_remove(message)
    pkcs7_padding_remove_bytes(message.each_char.map {|chr| chr.ord}).map do |byte|
      byte.chr
    end.join
  end

  def self.pkcs7_padding_remove_bytes(message_bytes)
    padding_length = message_bytes[message_bytes.length - 1]
    message_bytes[0...(message_bytes.length - padding_length)]
  end
end
