# frozen_string_literal: true

class AddIsDeletedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_deleted, :boolean, default: false
  end
end
