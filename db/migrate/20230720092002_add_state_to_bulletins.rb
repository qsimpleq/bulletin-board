# frozen_string_literal: true

class AddStateToBulletins < ActiveRecord::Migration[7.0]
  def up
    add_column :bulletins, :state, :string, default: 'draft'
    add_index :bulletins, :state
  end

  def down
    remove_column :bulletins, :state
  end
end
