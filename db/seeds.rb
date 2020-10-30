#Print error message and errors
#failed_descr: finish sentence "there was a problem seeding ________"
def put_errors(failed_descr,model)
  puts "There was a problem with seeding #{failed_descr}."
  puts "Errors Reported:"
  model.errors.full_messages.each{|err| puts " - #{err}"}
end

def save_or_put_err(failed_descr,model)
  model.valid? ? (model.save) : put_errors(failed_descr,model)
end

#in order, destroy all records, removing records from tables with FKs first
def destroy_all_tables
  [
    GameQuestion,
    Answer,
    GameQuestion,
    Question,
    Game,
    User
  ].each{|table| table.destroy_all}
end

#seed a single fake user
def seed_user
  seed_usr = User.new(name: "Tandem")
  save_or_put_err("the user",seed_usr)
end

def seed_questions
  #parse JSON file in <ProjectRoot>/lib
  path = File.join(File.dirname(__FILE__), "../lib/Apprentice_TandemFor400_Data.json")
  json = JSON.parse(File.read path)#[{...},{...},...{...}]
  
  json.each do |question_element|
    row = question_element.symbolize_keys
    
    #seed the question
    question = Question.new(body: row[:question])  
    
    #array of 4 answer attributes hashes
    question.answers.build(body: row[:correct], correct: true)
    row[:incorrect].each{|guess| question.answers.build(body: guess, correct: false)}
    save_or_put_err("question \"#{row[:question]}\"",question)
  end  
end

puts 'destroying tables...'
destroy_all_tables

puts 'seeding test user...'
seed_user

puts 'seeding questions & answers...'
seed_questions

