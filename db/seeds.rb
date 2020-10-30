puts 'destroying tables...'
destroy_all_tables

puts 'seeding test user...'
seed_user

puts 'seeding questions & answers...'
seed_questions

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
  seed_usr.valid? ? (seed_usr.save) : (put_errors("the user",seed_usr))
end

def seed_questions
  #parse JSON file in <ProjectRoot>/lib
  path = File.join(File.dirname(__FILE__), "../lib/Apprentice_TandemFor400_Data.json")
  json = JSON.parse(File.read path,:symbolize_names => true)#[{...},{...},...{...}]
  
  json.each do |row|
    #seed the question
    q = Question.new(body: row[:question])  
    
    #array of 4 answer attributes hashes
    q.answers.build(body: row[:correct], correct: true)
    row[:incorrect].each{|answ| q.answers.build(body: answ, correct: false)}
    end

    #save or display errors
    q.valid? ? (q.save) : (put_errors("question \"#{row[:question]}\"",q))    
  
end

#Print error message and errors
#failed_descr: finish sentence "there was a problem seeding ________"
def put_errors(failed_descr,model)
  puts "There was a problem with seeding #{failed_descr}."
  puts "Errors Reported:"
  model.errors.full_messages.each{|err| puts " - #{err}"}
end