class CreateUserPolls < ActiveRecord::Migration
  def change
    create_table :user_polls do |t|
      t.references :user, index: true
      t.references :my_poll, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_polls, :users
    add_foreign_key :user_polls, :my_polls
  end
end
