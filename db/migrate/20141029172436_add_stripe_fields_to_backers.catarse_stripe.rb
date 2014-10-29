# This migration comes from catarse_stripe (originally 20140731103558)
class AddStripeFieldsToBackers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_key, :string
    add_column :users, :stripe_userid, :string
    add_column :users, :stripe_access_token, :string
    add_column :projects, :stripe_userid, :string
    add_column :projects, :stripe_access_token, :string
    add_column :projects, :stripe_key, :string
  end
end
