class AddColumnsToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :brand, :string
    add_column :items, :fabric_details, :string
    add_column :items, :original_price, :integer
    add_column :items, :size, :string
  end
end
