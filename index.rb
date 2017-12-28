require 'sinatra'
# require 'sinatra/cors'
require 'sinatra/reloader' if development?

# set :allow_origin, "http://localhost:3000"

# On FE query `/start` to get o
# CHECK HOW TO RETURN JSON <3

# poses = [
#   'Jazz flute',
#   'Look left',
#   'Angry bear',
#   'Freezing cold',
#   'Sex fingers',
#   'Grumpy AF',
#   'Kiss',
#   'Waving',
#   'Douchebag',
#   'Vogue',
#   'Lick',
# ];


# get '/start' do
#   t = Time.now;
#   id = t.strftime('%s.%L')
#   puts "ID is #{id}"

#   @poses = poses.sample(4)
#   @id = id;

#   # Takes photo and saves in a file named Time.now
#   # %x(raspistill -vf -hf -o #{filename})
#   # %x(mkdir #{id})
#   # %x(touch #{id}/#{id}.angry.1.jpg)
#   # %x(touch #{id}/#{id}.angry.2.jpg)
#   # %x(touch #{id}/#{id}.angry.3.jpg)
#   # %x(touch #{id}/#{id}.cheese.1.jpg)
#   # %x(touch #{id}/#{id}.cheese.2.jpg)
#   # %x(touch #{id}/#{id}.cheese.3.jpg)
#   erb :index

#   # Send JSON objects back as a part of its response.
# end


get '/shutter/:id/:pose' do
  filepath = "photos/#{params[:id]}/#{params[:id]}.#{params[:pose]}"
  puts %x(mkdir photos/#{params[:id]})

  # Per pose - in order to get GIF!
  3.times do |n|  
     puts %x(touch #{filepath}.#{n + 1}.jpg)
  end  
  status :ok
  body ''
end



