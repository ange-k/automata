class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.integer    :tw_tweet_id, null: false
      t.references :user
      t.string     :text, null: false
      t.string     :urls, null: false
      t.datetime   :tweet_at, null: false
      t.timestamps
    end
  end
end
