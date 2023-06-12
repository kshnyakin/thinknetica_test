class Memory
  def long_method
    sleep 3
  end

  def memoization
    @m ||= long_method
  end
end