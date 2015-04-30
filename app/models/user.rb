class User < ActiveRecord::Base
   has_many   :places, :class_name=>'Place', :foreign_key=>"uid", :primary_key=> "uid"
	def self.create_with_omniauth(auth)
  		create! do |user|
        	#user.provider = auth["provider"]
    		user.uid = auth["uid"]
    		user.name = auth["info"]["name"]
         user.image= auth["info"]["image"]
         user.token= auth["credentials"]["token"]
         user.token_expires=Time.at(auth["credentials"]["expires_at"])
  		end
	end
end
