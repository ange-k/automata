class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.string     :tw_tweet_id, null: false
      t.references :user
      t.string     :text, null: true
      t.string     :urls, null: true
      t.datetime   :tweet_at, null: true
      t.timestamps
    end
    add_index :tweets, [:tw_tweet_id], unique: true
  end
end
