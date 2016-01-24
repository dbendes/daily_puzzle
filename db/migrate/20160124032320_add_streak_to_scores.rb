class AddStreakToScores < ActiveRecord::Migration
  def change
    add_column :scores, :streak, :integer
  end
end
