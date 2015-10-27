class CreateEmailPreferences < ActiveRecord::Migration
  def change
    create_table :email_preferences do |t|
      t.boolean :marketing
      t.boolean :daily
      t.boolean :weekly
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :email_preferences, :users
  end
end
