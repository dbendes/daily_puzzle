class CreateGroupInvites < ActiveRecord::Migration
  def change
    create_table :group_invites do |t|
      t.string :email
      t.references :group, index: true

      t.timestamps null: false
    end
    add_foreign_key :group_invites, :groups
  end
end
