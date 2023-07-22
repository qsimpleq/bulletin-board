# frozen_string_literal: true

def load_image(name)
  image_path = Rails.root.join("test/fixtures/files/#{name}")
  Rack::Test::UploadedFile.new(image_path)
end

def create_bulletins
  return if Bulletin.any?

  user = User.where(email: 'one@example.com').first
  titles = %w[animal_fox animal_owl animal_polarfox]
  category = Category.where(name: 'Животные').first
  states = %w[draft under_moderation published rejected archived]

  states.each do |state|
    build_bulletins = lambda do
      titles.each do |name|
        Bulletin.create!(
          category_id: category.id,
          creator_id: user.id,
          description: "#{category.name}: #{name}, with original state: #{state}",
          image: load_image("#{name}.jpg"),
          title: name,
          state:
        )
      end
    end

    build_bulletins.call

    titles = %w[vehicle_bike vehicle_car vehicle_wagon]
    category = Category.where(name: 'Транспорт').first
    build_bulletins.call
  end
end

create_bulletins
