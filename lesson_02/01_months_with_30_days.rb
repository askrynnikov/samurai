require 'date'

year = 2016
months_days = (1..12).reduce({}) do |val, i|
  val[Date.new(year, i).strftime('%B')] = Date.new(year, i, -1).day
  val
end

puts months_days
       .select { |_month, days| days == 30 }
       .map { |month, _days| month }
