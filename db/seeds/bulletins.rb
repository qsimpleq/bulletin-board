# frozen_string_literal: true

def load_image(name)
  image_path = Rails.root.join("test/fixtures/files/#{name}")
  Rack::Test::UploadedFile.new(image_path)
end

def create_bulletins
  return if Bulletin.any?

  users = User.all
  titles = %w[animal_fox animal_owl animal_polarfox vehicle_bike vehicle_car vehicle_wagon]
  categories = Category.all
  states = Bulletin.states

  ActiveRecord::Base.transaction do
    1.upto(2000) do |num|
      user = users.sample
      title = titles.sample
      category = categories.sample
      state = states.sample
      Bulletin.create(
        category_id: category.id,
        user_id: user.id,
        description: "#{category.name}: #{title}, with original state: #{state}",
        image: load_image("#{title}.jpg"),
        title: "#{num}: #{title} from: #{user.name}",
        state: state.to_s
      )
    end
  end
end

create_bulletins
