class CreateWines < ActiveRecord::Migration[7.1]
  def change
    create_table :wines do |t|
      t.string :name
      t.string :country
      t.string :region
      t.string :domain
      t.text :description
      t.integer :year
      t.float :price
      t.string :category
      t.integer :stock_quantity
      t.string :grape_variety
      t.float :alcohol_level
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
