class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, uniqueness: true, presence: true
      t.string :email, uniqueness: true, presence: true
      t.timestamps
    end
  end
end
