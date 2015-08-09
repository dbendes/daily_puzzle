class ChangeDataTypeForScore < ActiveRecord::Migration
  def change
    change_column :scores, :value, :float
  end
end
