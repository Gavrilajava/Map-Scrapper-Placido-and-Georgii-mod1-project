require_relative './config/environment'



Place.where(name:  "Beer Nation").each do |place|
    pp place
end