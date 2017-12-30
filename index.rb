require 'sinatra'
# require 'sinatra/cors'
require 'sinatra/reloader' if development?
require 'json'

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
  # LIVE MODE
  #dir_path = "/home/pi/photobooth/f1_raw/#{params[:id]}/"
  dir_path = "public/f1_raw/#{params[:id]}/"  
  filepath = "#{dir_path}/#{params[:id]}.#{params[:pose]}"
  puts %x(mkdir #{dir_path})  
  puts %x(raspistill -bm -md 1 -q 80 -t 1400 -tl 0 --nopreview -o #{filepath}.%02d.jpg)

  # TEST MODE
  #dir_path = "./f3_done/#{params[:id]}/"
  #filepath = "#{dir_path}/#{params[:id]}.#{params[:pose]}"
  #puts %x(mkdir #{dir_path})  

  #3.times do |n|  
  #   puts %x(touch #{filepath}.#{n}.jpg)
  #end  

  status :ok
  body ''
end

get '/gallery' do

  # Will return an an array of objects, one object per photoset
  photosets = Array.new 

	Dir.glob("public/f4_gifs/*") do |x| 
    #Each ID/directory. This should list on the gifs dir, not photos
    if FileTest.directory?(x) 
      puts "Is a directory: #{x}" 
      id = File.basename(x)
      data = Array.new 

      Dir.glob("#{x}/*.gif") do |gif|
        #Each file/photo within
        # gif_filename  = File.basename(gif)
        gif_filename  = gif.split('/')[1...999].join('/')
        pose          = gif_filename[/\.([^\.]+)\./, 1]
        photos        = Array.new 

        Dir.glob("public/f3_done/#{id}/#{id}.#{pose}.*.jpg") do |photo|
          photos << photo.split('/')[1...999].join('/')
        end

        data << {"pose": pose, "gif": gif_filename, "photos": photos}
      end

      photosets << {"id": id, "data": data} 
    else 
      puts "ISNT a directory: #{x}"
    end
  end

  content_type :json
  photosets.to_json
  #body '[ { "id":"12312341414", "data": [{pose: "waving", gif: "blah.gif", pics: [1,2,3,4] }, {}, {}, {}] }, {id} ,{id}  ]'
end
