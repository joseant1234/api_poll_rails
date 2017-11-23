class MyAnswer < ActiveRecord::Base
  belongs_to :user_poll
  belongs_to :answer
  belongs_to :question

  validates :answer, presence: true
  validates :user_poll, presence: true

  def self.custom_update_or_create(user_poll,answer)
  	#Validando que no se creen dos registros para la misma pregunta y el mismo usuario
  	my_answer = where(user_poll: user_poll, question: answer.question).first_or_create

  	#Actualiza la respuesta elegida a la que se envió por parámetro
  	my_answer.update(answer: answer)


  	#retorna el registro de MyAnswer
  	my_answer
  end

end
