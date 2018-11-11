class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer  :tw_user_id, null: false
      t.string   :name, null: false
      t.integer  :followers_count, null: false
      t.integer  :statuses_count, null: false
      t.timestamps
    end
  end
end
