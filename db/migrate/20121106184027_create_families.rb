class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.timestamps
    end

    add_column :users, :family_id, :integer
  end
end
