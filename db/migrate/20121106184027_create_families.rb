class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :name

      t.timestamps
    end

    add_column :users, :family_id, :integer
    add_column :users, :first_name, :string, default: ""
    add_column :users, :last_name, :string, default: ""

    remove_column :users, :name
  end
end
