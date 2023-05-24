# Файл в котором происходит управление классами Station / Route / Train
require_relative "station"
require_relative "route"
require_relative "train"

station = Station.new
route = Route.new
train = Train.new

puts "station = #{station.class}"
puts "route = #{route.class}"
puts "train = #{train.class}"
