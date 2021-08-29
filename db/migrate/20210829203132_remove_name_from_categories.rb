# frozen_string_literal: true

class RemoveNameFromCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :name, :string, null: false, unique: true
  end
end
