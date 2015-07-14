require "./substitution_constants.rb"
require "../challenge1/conversion.rb"

module Substitution
  def self.sub_byte(byte)
    decode_from_hex s_box[(byte & 0xf0) >> 4][byte & 0x0f]
  end

  def self.sub_byte_inverse(byte)
    decode_from_hex s_box_inverse[(byte & 0xf0) >> 4][byte & 0x0f]
  end
end
