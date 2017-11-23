class CreateMyAnswers < ActiveRecord::Migration
  def change
    create_table :my_answers do |t|
      t.references :user_poll, index: true
      t.references :answer, index: true

      t.timestamps null: false
    end
    add_foreign_key :my_answers, :user_polls
    add_foreign_key :my_answers, :answers
  end
end
