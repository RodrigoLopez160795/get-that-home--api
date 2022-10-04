class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.text :address
      t.integer :price
      t.integer :maintenance
      t.integer :property_type
      t.integer :operation_type
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :area
      t.boolean :pets
      t.text :about
      t.references :user, null: false, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
