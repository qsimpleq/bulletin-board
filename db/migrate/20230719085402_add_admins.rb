# frozen_string_literal: true

class AddAdmins < ActiveRecord::Migration[7.0]
  def change
    User.find_by(email: 'kirill.babikhin@gmail.com')&.update(admin: true)
  end
end
