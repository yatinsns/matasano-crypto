require "./mix_columns_constants.rb"

module MixColumns
  def self.mult_2(byte)
    self.mult_2_lookup[byte]
  end

  def self.mult_3(byte)
    self.mult_3_lookup[byte]
  end

  def self.mult_9(byte)
    self.mult_9_lookup[byte]
  end

  def self.mult_11(byte)
    self.mult_11_lookup[byte]
  end

  def self.mult_13(byte)
    self.mult_13_lookup[byte]
  end

  def self.mult_14(byte)
    self.mult_14_lookup[byte]
  end
end
