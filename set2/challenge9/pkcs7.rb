def pkcs7_padding_add(message, block_size)
  padding_length = block_size - (message.length % block_size)
  message.ljust(message.length + padding_length,
                padding_length.chr)
end

def pkcs7_padding_remove(message, block_size)
  padding_length = message[message.length - 1].ord
  message.slice(0, message.length - padding_length)
end
