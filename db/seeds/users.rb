# frozen_string_literal: true

def create_users
  return if User.any?

  %w[
    one
    two
    three
    four
    five
    six
    seven
    eight
    nine
    ten
  ].each_with_index do |name, index|
    User.create!(
      admin: true,
      name: "User #{name}",
      email: "#{name}@example.com",
      provider: :github,
      uid: index
    )
  end
end

create_users
