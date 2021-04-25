require './Organizer/Questions.rb'

if __FILE__ == $0

    list = Questions.new('./data/questions.json', './data/question_access.json')
    p list.mostAccessedQuestions.map {|hash| hash["totalAccess"]}

end