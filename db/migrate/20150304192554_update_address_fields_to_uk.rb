class UpdateAddressFieldsToUk < ActiveRecord::Migration
  def change
    drop_view :backer_reports_for_project_owners

    remove_column :backers, :address_complement
    remove_column :backers, :address_neighbourhood
    remove_column :backers, :address_number

    remove_column :users, :address_complement
    remove_column :users, :address_neighbourhood
    remove_column :users, :address_number

    rename_column :backers, :address_street, :address_1
    rename_column :backers, :address_state, :address_county

    rename_column :users, :address_street, :address_1
    rename_column :users, :address_state, :address_county

    add_column :backers, :address_2, :text
    add_column :backers, :address_3, :text
    add_column :backers, :address_country, :text

    add_column :users, :address_2, :text
    add_column :users, :address_3, :text
    add_column :users, :address_country, :text

    create_view :backer_reports_for_project_owners, "
    SELECT
      b.project_id,
      r.id as reward_id,
      r.description as reward_description,
      b.confirmed_at::date,
      b.value as back_value,
      (b.value* (SELECT value::numeric FROM configurations WHERE name = 'catarse_fee') ) as service_fee,
      u.email as user_email,
      b.payer_email as payer_email,
      b.payment_method,
      coalesce(b.address_1, u.address_1) as address_1,
      coalesce(b.address_2, u.address_2) as address_2,
      coalesce(b.address_3, u.address_3) as address_3,
      coalesce(b.address_city, u.address_city) as city,
      coalesce(b.address_county, u.address_county) as county,
      coalesce(b.address_zip_code, u.address_zip_code) as zip_code
      coalesce(b.address_country, u.address_country) as country,
    FROM
      backers b
    JOIN users u ON u.id = b.user_id
    LEFT JOIN rewards r ON r.id = b.reward_id
    WHERE
      b.confirmed;
    "
  end
end
