class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events, :force => true do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :family_id

      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
