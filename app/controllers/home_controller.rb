class HomeController < ApplicationController
     
   def front
   end
   
   
  def index
     if current_user
        @graph = Koala::Facebook::API.new(current_user.token)
        @places = @graph.get_connections("me","tagged_places")
        puts @places
        
        @places.each do |place|           
           @plc=Place.find_by uid: current_user.uid, lat: place["place"]["location"]["latitude"].to_s, lang: place["place"]["location"]["longitude"].to_s 
           puts @plc
           if !@plc
              @plc=Place.new()
              @plc.uid=current_user.uid
              @plc.name=place["place"]["name"]
              @plc.lat=place["place"]["location"]["latitude"]
              @plc.lang=place["place"]["location"]["longitude"] 
              @plc.byuser=false
              @plc.save!
           end
        end
        @ps=Place.where("uid = ? ", current_user.uid)
        @hash = Gmaps4rails.build_markers(@ps) do |place, marker|
           marker.infowindow view_context.link_to(place.name, :pa =>place.name)
           marker.title place.name
           marker.lat place.lat
           marker.lng place.lang
        end
     end
     if params[:pa]
            @pan=Place.find_by_name(params[:pa])
            @instagram=Hashie::Mash.new HTTParty.get("https://api.instagram.com/v1/media/search?lat=#{@pan.lat}&lng=#{@pan.lang}&client_id="+ENV["CLIENT_ID"])
     end
  end
end

   
   
      
