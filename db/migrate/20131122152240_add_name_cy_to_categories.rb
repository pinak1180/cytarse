class AddNameCyToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :name_cy, :string
  end
end
