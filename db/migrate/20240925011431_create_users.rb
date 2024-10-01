class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :address_web
      t.string :github_username
      t.integer :followers
      t.integer :following
      t.integer :stars
      t.integer :contributions
      t.string :profile_image_url
      t.string :organization
      t.string :location
      t.timestamps
    end
  end
end
