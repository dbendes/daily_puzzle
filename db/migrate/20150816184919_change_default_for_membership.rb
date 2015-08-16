class ChangeDefaultForMembership < ActiveRecord::Migration
  def change
    change_column :memberships, :type, :int, :default => 0
  end
end
