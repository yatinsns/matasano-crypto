def pkcs7_padding(message, block_size)
  padding_length = block_size - (message.length % block_size)
  message.ljust(message.length + padding_length,
                padding_length.chr)
end
