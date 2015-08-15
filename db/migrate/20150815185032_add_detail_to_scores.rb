class AddDetailToScores < ActiveRecord::Migration
  def change
    add_column :scores, :detail, :string, :default => " "
  end
end
