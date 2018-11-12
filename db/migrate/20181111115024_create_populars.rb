class CreatePopulars < ActiveRecord::Migration[5.1]
  def change
    create_table :populars do |t|
      t.references :tweet
      t.references :user
      t.integer  :retweet_count, null: false
      t.integer  :favorite_count, null: false
      t.datetime :search_date, null: true
      t.float    :popular, null: false
      t.timestamps
    end
  end
end
