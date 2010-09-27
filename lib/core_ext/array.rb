class Array
  def sum
    inject( nil ) { |sum,x| sum ? sum+x : x }
  end
end