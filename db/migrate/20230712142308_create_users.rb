# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, index: true
      t.string :name, index: true
      t.string :provider, index: true
      t.string :uid, index: true

      t.timestamps
    end

    add_index :users, %i[provider uid], unique: true
  end
end
