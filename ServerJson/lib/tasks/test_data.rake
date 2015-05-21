namespace :test_data do

  task :test_geo_moscow => :environment do
    Event.all.each do |e|
      e.longitude = 37.61987371
      e.latitude = 55.753703
      e.save
    end
  end

end