# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title, null: false, default: '', index: true
      t.string :description, null: false, default: ''
      t.monetize :price, null: false, default: 0
      t.monetize :old_price, null: false, default: 0
      t.integer :status, null: false, default: 0, index: true
      t.string :poster
      t.integer :quantity, null: false, default: 0
      t.boolean :active, null: false, default: true

      t.timestamps
    end

    add_index :products, :price_cents
  end
end
