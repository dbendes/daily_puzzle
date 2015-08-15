class AddDetailedToGames < ActiveRecord::Migration
  def change
    add_column :games, :detailed, :boolean, :default => false
  end
end
