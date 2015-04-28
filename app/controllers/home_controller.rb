class HomeController < ApplicationController
   def front
   end
   
   
  def index
     if current_user
        @graph = Koala::Facebook::API.new(current_user.token)
        @places = @graph.get_connections("me", "tagged_places") 
        @places.each do |place|           
           plc=Place.find_by uid: current_user.uid, lat: place["place"]["location"]["latitude"].to_s, lang: place["place"]["location"]["longitude"].to_s 
           if plc.nil?
              plc=Place.new()
              plc.uid=current_user.uid
              plc.name=place[   "place"]["name"]
              plc.lat=place["place"]["location"]["latitude"]
              plc.lang=place["place"]["location"]["longitude"] 
              @instagram=HTTParty.get("https://api.instagram.com/v1/locations/search?lat=#{plc.lat}&lng=#{plc.lang}&client_id=62f331796f0549ca9eeece6831642f0f")
              puts @instagram
              plc.save!
           end
        end
        @ps=Place.where("uid = ? ", current_user.uid)
        @hash = Gmaps4rails.build_markers(@ps) do |user, marker|
           marker.lat user.lat
           marker.lng user.lang
        end   
        
       
     end
  end     
   
   def insta
      
   end
end
