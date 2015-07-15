require "./mix_columns_constants.rb"

module MixColumns
  def self.mult_2(byte)
    self.mult_2_lookup[byte]
  end

  def self.mult_3(byte)
    self.mult_3_lookup[byte]
  end
end
