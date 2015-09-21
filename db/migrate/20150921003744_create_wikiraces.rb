class CreateWikiraces < ActiveRecord::Migration
  def change
    create_table :wikiraces do |t|
      t.string :start
      t.string :end
      t.date :racedate
      t.text :start_description
      t.text :end_description

      t.timestamps null: false
    end
  end
end
