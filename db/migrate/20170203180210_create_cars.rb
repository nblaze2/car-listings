class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.string :model, null: false
      t.string :color, null: false
      t.integer :year, null: false
      t.integer :mileage, null: false
      t.text :description
      t.belongs_to :manufacturer, foreign_key: true, null: false
      t.timestamps null: false
    end
  end
end
