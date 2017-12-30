require 'sinatra'
# require 'sinatra/cors'
require 'sinatra/reloader' if development?

set :bind, '0.0.0.0'

# set :allow_origin, "http://localhost:3000"

# On FE query `/start` to get o
# CHECK HOW TO RETURN JSON <3


# get '/start' do
#   t = Time.now;
#   id = t.strftime('%s.%L')
#   puts "ID is #{id}"

#   @poses = poses.sample(4)
#   @id = id;

#   # Takes photo and saves in a file named Time.now
#   # %x(raspistill -vf -hf -o #{filename})
#   erb :index

#   # Send JSON objects back as a part of its response.
# end


get '/shutter/:id/:pose' do
  headers 'Access-Control-Allow-Origin' => '*'
  filepath = "/home/pi/photobooth/f1_raw/#{params[:id]}/#{params[:id]}.#{params[:pose]}"
  puts %x(mkdir /home/pi/photobooth/f1_raw/#{params[:id]})

  # Per pose - in order to get GIF!
  #3.times do |n|  
     #puts %x(touch #{filepath}.#{n + 1}.jpg)
  puts %x(raspistill -bm -md 1 -q 80 -t 1400 -tl 0 --nopreview -o #{filepath}.%02d.jpg)
  #end  
  status :ok
  body ''
end

get '/gallery'
	body '[ { "id":"12312341414", "data": [{pose: "waving", gif: "blah.gif", pics: [1,2,3,4] }, {}, {}, {}] }, {id} ,{id}  ]'
end



