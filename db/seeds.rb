[Score,Answer,CorrectlyAnswered,Question,User]
.each{|table| table.destroy_all}

#create one user
seedUsr = User.new(name: "Tandem")
if seedUsr.valid?
  seedUsr.save
  puts 'Seeded User Sucessfully'
else
  puts 'There was a problem seeding the user'
end

path = File.join(File.dirname(__FILE__), "../lib/Apprentice_TandemFor400_Data.json")
json = JSON.parse(File.read path,:symbolize_names => true)

json.each do |row|
  q = Question.new(body: row[:question])
  if q.valid?
    q.save
  else
    puts 'There was a problem seeding a question "' + row[:question] + '"'
  end

  answerAttr = [{body: row[:correct], correct: true}]
  row[:incorrect].each do |answ|
    answerAttr << {body: answ, correct: false}
  end

  answers = Answer.new(answerAttr)
  
end