class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email,              :null => false, :default => ""

      t.integer :family_id
      t.integer :user_id
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
