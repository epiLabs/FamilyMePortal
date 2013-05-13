class CreateTaskLists < ActiveRecord::Migration
  def change
    create_table :task_lists do |t|
      t.string :title
      t.text :description
      t.integer :author_id
      t.integer :family_id

      t.timestamps
    end
  end
end
