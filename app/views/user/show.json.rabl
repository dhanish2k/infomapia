object @user
attributes :name, :image

child :places do 
   attributes :id, :name, :lat, :lang
end