require './Organizer/Questions.rb'

if __FILE__ == $0
    DEFAULT = {:questions => './data/questions.json', :access => './data/question_access.json'}
    questionPath = DEFAULT[:questions]
    questionAccessPath = DEFAULT[:access]

    p "Do you want to select custom files?   Y/N"

    if (gets.chomp.casecmp("Y")) == 0
        p "Type questions file path:"
        questionPath = gets.chomp

        p "Type question access file path:"
        questionAccessPath = gets.chomp
    end

    list = Questions.new(questionPath, questionAccessPath)

    loop do
        p "1 - List Questions"
        p "2 - List Questions ordered by access"
        p "3 - List Disciplines ordered by access"
        p "0 - Exit"
        p "Type your chosen number"

        case (gets.chomp)
        when "1"
            p list.questions
        when "2"
            
            p "Time range:"
            p "1 - week"
            p "2 - month"
            p "3 - year"
            p "0 - cancel"
            p "Type your chosen number"

            case Integer(gets.chomp)
            when 1
                p list.mostAccessedQuestions('week')
            when 2
                p list.mostAccessedQuestions('month')
            when 3
                p list.mostAccessedQuestions('year')
            when 0
                next
            else
                p "No number found"
            end
        when "3"
            p "Type a number of hours range before now"
            p list.mostAccessedDisciplines(Integer(gets.chomp))
        when "0"
            break
        else
            p "Could'nt understand your code, please type only available number"
        end
    end
    

end