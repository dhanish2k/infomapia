class HomeController < ApplicationController
   def front
   end
   
   
  def index
     if current_user
        @graph = Koala::Facebook::API.new(current_user.token)
        @places = @graph.get_connections("me", "tagged_places") 
        @places.each do |place|           
           @plc,@ter=Place.find_by uid: current_user.uid, lat: place["place"]["location"]["latitude"].to_s, lang: place["place"]["location"]["longitude"].to_s 
           if @plc.nil?
              @plc=Place.new()
              @plc.uid=current_user.uid
              @plc.name=place["place"]["name"]
              @plc.lat=place["place"]["location"]["latitude"]
              @plc.lang=place["place"]["location"]["longitude"] 
              @plc.save!
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
      plc=Place.find_by_name(params[:pa])
      @instagram=HTTParty.get("https://api.instagram.com/v1/locations/search?lat=#{plc.lat}&lng=#{plc.lang}&client_id="+ENV["CLIENT_ID"])
      puts @instagram
   end
end
