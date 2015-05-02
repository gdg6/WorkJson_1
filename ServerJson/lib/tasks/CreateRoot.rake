namespace :baseTasks do

  desc "createRoot"
  task :createRoot => :environment do
    u = User.new
    u.Login="gdg6"
    u.Admin=true
    u.Email="zhulvern-92@mail.ru"
    u.CharacterName="Gamer"
    u.password="qwerty"
    u.City="Moscow"
    u.save
  end

end