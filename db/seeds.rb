# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: "uriel@codigofacilito.com", uid: "123asd123213", provider:"facebook")

poll = MyPoll.create(title: "Que lenguaje de programacion es el mejor para ti",
										description: "Queremos saber que lenguajes son los preferidos de la gente",
										expires_at: DateTime.now + 1.year,
										user: user)

question = Question.create(description: "Te importa la eficiencia de ejecución del programa?",
													my_poll: poll)

answer = Answer.create(description: "a) Sí, me importa mucho", question: question)