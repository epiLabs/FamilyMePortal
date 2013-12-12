class AddIcalTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ical_token, :string
  end
end
