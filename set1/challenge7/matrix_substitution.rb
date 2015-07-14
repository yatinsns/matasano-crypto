require "./matrix.rb"
require "./substitution.rb"

module Matrix
  class Matrix_128
    def substitute
      self.set_bytes(self.get_bytes.map do |byte|
        Substitution.sub_byte byte
      end)
    end
  end
end

