# frozen_string_literal: true

class ChangeCreatorNameInBulletins < ActiveRecord::Migration[7.0]
  def change
    rename_column :bulletins, :creator_id, :user_id
  end
end
