# frozen_string_literal: true

def create_categories
  return if Category.any?

  [
    'Для дома и дачи',
    'Животные',
    'Личные вещи',
    'Недвижимость',
    'Работа',
    'Транспорт',
    'Хобби и отдых',
    'Электроника'
  ].each { |name| Category.create!(name:) }
end

create_categories
