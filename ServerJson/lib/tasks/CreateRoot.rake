namespace :baseTasks do

  desc "createRoot"
  task :createRoot => :environment do
  end

  desc "createUrlInEvent"
  task :createUrlInEvent do
    Event.all.each{|x| x.url = x.picture.url(:medium); x.save}
    p "ok"
  end

end