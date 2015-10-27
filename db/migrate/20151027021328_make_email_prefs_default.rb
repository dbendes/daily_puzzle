class MakeEmailPrefsDefault < ActiveRecord::Migration
  def change
    change_column :email_preferences, :weekly, :boolean, :default => true
    change_column :email_preferences, :daily, :boolean, :default => true
    change_column :email_preferences, :marketing, :boolean, :default => true
  end
end
