module ShiftRow
  def self.shift_row(bytes, count)
    bytes.rotate count
  end
end
