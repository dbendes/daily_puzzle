class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|
      t.string :url
      t.text :description
      t.references :game

      t.timestamps null: false
    end
  end
end
