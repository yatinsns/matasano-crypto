require "./substitution_constants.rb"
require "../challenge1/conversion.rb"

module Substitution
  def self.sub_byte(byte)
    s_box[(byte & 0xf0) >> 4][byte & 0x0f].to_i 16
  end

  def self.sub_byte_inverse(byte)
    s_box_inverse[(byte & 0xf0) >> 4][byte & 0x0f].to_i 16
  end
end
