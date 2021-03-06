namespace :insertData do

  cities = %w(Москва Санкт-Петербург Казань)
  desc "createCities"
  task :createCities => :environment do
    cities.each do |c|
      k = City.new
      k.name = c
      k.save
    end
  end


  characters = ['Студент', 'Хипстер', 'Активный', 'Мамочка', 'Музыкант', 'Интеллектуал', 'Патриот']
  student = ['Вечеринки', 'Питейные заведения', 'Кино', "Фестиваль", "Квесты", "Коворкинги", "Пиццерии", "Музеи", "Природа"]
  hipster = ["Концерты - инди", "Концерты - альтернатива", "Мода", "Мода", "Исскуство", "Рестораны", "Артхаусное кино", "Вечеринки", "Тату салоны", "Стрит-арт"]
  active = ["Квесты", "Крыши", "Заброшеные места", "Прогулка на природе", "Активный спорт", "Экстримальный спорт", "Природа"]
  mam = ["Лекции", "Дети", "Фитнес", "Парки развлечений", "Развивающий центр", "Детские праздники и мероприятия", "Детские кафе", "Курсы для мам", "Детские магазины", "Работа для мам", "Кулинарные курсы"]
  music = ["Рок", "Металл", "Альтернатива", "Джаз", "Блюз", "Соул", "Электронная музыка", "Рэп", "Хип-хоп", "Классическая музыка", "Поп", "Эстрада", "Инди", "Кантри", "Фолк", "Панк", "Регги", "Диско", "Фанк", "Латина", "Бардовская песня", "Шансон"]
  genius = ["Театр", "Экскурсии", "Экспошоу", "Выставки", "Лекции", "Искуство", "Рестораны", "Библиотеки", "Книжные ярмарки"]
  patriot = ["Реконструкции", "Музеи", "Военные праздники", "Гражданские мероприятия", "Митинги", "Политические мероприятия", "События города", "Марши", "Благотворительные акции", "Волонтерское движение"]
  all_tags = [student, hipster, active, mam, music, genius, patriot]
  desc "createCharacterAndTag"
  task :createCharacterAndTag => :environment do
    characters.each do |c|
      ch = Character.new
      ch.title = c
      ch.save
    end

    i = 1
    all_tags.each do |arr|
      arr.each do |tag|
        t = Tag.new
        t.context = tag
        t.save
        ttc = TagsToCharacter.new
        ttc.character_id = i
        ttc.tag_id = t.id
        ttc.save
      end
      i = i + 1
    end
  end

  #
  # event_names = ['Вечеринка у павлика', "Концерт AC/DC", "Музей партизана"]
  # desc "createTestEvent"
  # task :createTestEvent => :environment do
  #   event_names.each do |n|
  #     e = Event.new
  #     e.name = n
  #     # e.adress =
  #   end
  # end

end
