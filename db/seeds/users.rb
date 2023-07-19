# frozen_string_literal: true

def create_users
  return if User.any?

  User.create!(
    admin: true,
    email: 'one@example.com',
    provider: :github,
    uid: 12_345
  )
end

create_users
