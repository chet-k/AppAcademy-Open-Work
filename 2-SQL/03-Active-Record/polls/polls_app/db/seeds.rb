# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: 'Chet') #1
User.create(username: 'Hannah') #2
User.create(username: 'Toby') #3

Poll.create(title: 'Cookies', user_id: 1) #1
Question.create(poll_id: 1, text:'What is your favorite cookie?') #1
AnswerChoice.create(question_id: 1, text: 'Chocolate Chip') #1
AnswerChoice.create(question_id: 1, text: 'Sugar') #2
AnswerChoice.create(question_id: 1, text: 'Oatmeal') #3
Question.create(poll_id: 1, text:'How many cookies can you eat at one time?') #2
AnswerChoice.create(question_id: 2, text: '0-1') #4
AnswerChoice.create(question_id: 2, text: '2') #5
AnswerChoice.create(question_id: 2, text: '3') #6
AnswerChoice.create(question_id: 2, text: '4+') #7
Question.create(poll_id: 1, text: 'How many times per month do you make cookies?') #3
AnswerChoice.create(question_id: 3, text: '0-1') #8
AnswerChoice.create(question_id: 3, text: '2') #9
AnswerChoice.create(question_id: 3, text: '3') #10
AnswerChoice.create(question_id: 3, text: '4+') #11

Poll.create(title: 'Candy', user_id: 2) #2
Question.create(poll_id: 2, text: 'Choose a candy type:') #4
AnswerChoice.create(question_id: 4, text: 'Sour') #12
AnswerChoice.create(question_id: 4, text: 'Chocolate') #13
Question.create(poll_id: 2, text: 'What is the best sour patch?') #5
AnswerChoice.create(question_id: 5, text: 'Sour Patch Kids') #14
AnswerChoice.create(question_id: 5, text: 'Sour Patch Watermelon') #15

Poll.create(title: 'Kibble', user_id: 3)
Question.create(poll_id: 3, text: 'How often does Toby need to be fed?') #6
AnswerChoice.create(question_id: 6, text: 'Once a day') #15
AnswerChoice.create(question_id: 6, text: 'Twice a day') #16
AnswerChoice.create(question_id: 6, text: 'Whenever he meows') #17

#Chet responses
Response.create(user_id: 1, answer_choice_id: 1)
Response.create(user_id: 1, answer_choice_id: 7)
Response.create(user_id: 1, answer_choice_id: 9)
Response.create(user_id: 1, answer_choice_id: 13)
Response.create(user_id: 1, answer_choice_id: 14)
Response.create(user_id: 1, answer_choice_id: 16)

#Hannah responses
Response.create(user_id: 2, answer_choice_id: 1)
Response.create(user_id: 2, answer_choice_id: 4)
Response.create(user_id: 2, answer_choice_id: 8)
Response.create(user_id: 2, answer_choice_id: 12)
Response.create(user_id: 2, answer_choice_id: 15)
Response.create(user_id: 2, answer_choice_id: 16)

#Toby responses
Response.create(user_id: 3, answer_choice_id: 2)
Response.create(user_id: 3, answer_choice_id: 4)
Response.create(user_id: 3, answer_choice_id: 8)
Response.create(user_id: 3, answer_choice_id: 12)
Response.create(user_id: 3, answer_choice_id: 15)
Response.create(user_id: 3, answer_choice_id: 17)