class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :user_id
      t.integer :task_list_id
      t.boolean :finished, default: false

      t.timestamps
    end
  end
end
