class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.timestamps
    end

    add_column :users, :family_id, :integer
    add_column :users, :first_name, :string, default: ""
    add_column :users, :last_name, :string, default: ""
  end
end
