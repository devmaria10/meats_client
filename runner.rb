require 'unirest'

system 'clear'

puts "Welcome to My Meats App"

puts "Please select an option:"
puts "   [1] See all meats"
puts "   [2] See a particular meat"
puts "   [3] Create a new meat item"
puts "   [4] Update a meat item"
puts "   [5] Delete a meat item"

input_option = gets.chomp 

if input_option == "1"
  response = Unirest.get("http://localhost:3000/meats")
  meats = response.body
  puts JSON.pretty_generate(meats)
elsif input_option == "2"
  puts "Enter Meat id"
  input_id = gets.chomp
  response = Unirest.get("http://localhost:3000/meats/#{input_id}")
  meat = response.body
  puts JSON.pretty_generate(meat)

elsif input_option == "3"

  puts "Enter in the following information to create a new meat item: "

  client_params = {}

  print "well_done status"
  client_params[:well_done] = gets.chomp

  print "cow emotion prior to slaughter"
  client_params[:emotion] = gets.chomp 

  p client_params


  response = Unirest.post("http://localhost:3000/meats", 
                        parameters: client_params
                        )
  meat = response.body 

  puts JSON.pretty_generate(meat)
elsif input_option == "4"
  puts "Enter Meat id"
  input_id = gets.chomp

  response = Unirest.get("http://localhost:3000/meats/#{input_id}")
  meat.json = response.body

  puts "Enter in the following information to update a meat item: "

  client_params = {}

  print "well_done status(#{meat.json["well_done"]}): "
  client_params[:well_done] = gets.chomp

  print "cow emotion prior to slaughter(#{meat.json["emotion"]}): "
  client_params[:emotion] = gets.chomp 

  client_params.delete_if {|key, value| value.empty? }


  response = Unirest.patch("http://localhost:3000/meats/#{input_id}", 
                        parameters: client_params
                        )
  updated_meat = response.body 

  puts JSON.pretty_generate(updated_meat)
elsif input_option == "5"
  puts "Enter Meat id"
  input_id = gets.chomp

  response = Unirest.delete("http://localhost:3000/meats/#{input_id}")
  data = response.body
  puts data["message"]






end 
