class String
  def fixed_width_length_with_left_padding(length, padding_chr)
    ("%#{length}.#{length}s" % self).gsub(' ', padding_chr)
  end

  def repeat_for_length(length)
    Array.new((length / self.length) + 1, self).join.slice(0, length)
  end
end
