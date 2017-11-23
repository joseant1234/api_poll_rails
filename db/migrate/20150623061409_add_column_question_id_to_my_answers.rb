class AddColumnQuestionIdToMyAnswers < ActiveRecord::Migration
  def change
    add_reference :my_answers, :question, index: true
    add_foreign_key :my_answers, :questions
  end
end
