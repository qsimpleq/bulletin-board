# frozen_string_literal: true

class CreateBulletins < ActiveRecord::Migration[7.0]
  def change
    create_table :bulletins do |t|
      t.string :title, index: true
      t.text :description, index: true
      t.references :creator, class_name: :user, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
