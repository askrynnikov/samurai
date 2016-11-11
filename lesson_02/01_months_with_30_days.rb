require 'date'

year = 2016
months_30_days = (1..12).reduce([]) do |val, i|
  month_last_day = Date.new(year, i, -1)
  val << month_last_day.strftime('%B') if month_last_day.day == 30
  val
end

puts months_30_days
