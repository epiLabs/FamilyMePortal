class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :author_id
      t.integer :family_id

      t.text :message

      t.timestamps
    end
  end
end
