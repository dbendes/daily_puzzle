class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :value
      t.date :date
      t.references :game, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :scores, :games
    add_foreign_key :scores, :users
  end
end
