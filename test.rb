require_relative './config/environment'

APIScrapper.geocode ("Altayskaya Saint petersburg")

puts "#{APIScrapper.coordinates[:lat]},#{APIScrapper.coordinates[:lon]}"