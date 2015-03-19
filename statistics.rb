#open file
f = File.new("./act_schools_FINAL_2001_to_2014_By_Group_With_ELL_20140819.csv", "r")
act_string = f.read
f.close

#Converts string of data into an array of data
act_points = act_string.split("\n")
first_row = act_points.shift

#Go through each data point and fetch the needed value by splitting it into an array of data values
sum = 0
act_points.each do |act_point|
  act_point_values = act_point.split(',')
  act_score = act_point_values[11]
  sum = sum + act_score.to_f
end

#find average of the act scores
average = sum / act_points.count
puts "Average:"
puts average

#find the standard deviation
variance = 0
act_points.each do |act_point|
  act_point_values = act_point.split(',')
  act_score = act_point_values[11]
  variance = variance + (act_score.to_f - average)**2
end
standard_deviation = (variance/ act_points.count)**0.5

#put standard deviation
puts "Standard Deviation:"
puts standard_deviation

#find z-score
z_scores = []
act_points.each do |act_point|
  act_point_values = act_point.split(',')
  act_score = act_point_values[11]
  z_score = (act_score.to_f - average.to_f / standard_deviation)
  z_scores.push act_point + "," + z_score.to_s
end

#put z-score
puts "Z-Scores:"
puts z_scores

#put titles back at the top
z_scores.unshift(first_row)

#open file and add z-scores
f = File.open("./act_schools_FINAL_2001_to_2014_By_Group_With_ELL_20140819_new.csv", "w")
f.write z_scores.join("\n")
f.close