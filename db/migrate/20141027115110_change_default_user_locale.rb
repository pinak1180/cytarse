class ChangeDefaultUserLocale < ActiveRecord::Migration
  def change
    change_column :users, :locale, :string, default: 'en', null: false
  end
end
