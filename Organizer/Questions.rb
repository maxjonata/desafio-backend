require_relative './FileUser.rb'
require 'date'
require 'daru'

class Questions
    
    include FileUser

    def initialize(questionFilePath, accessFilePath)
        @questionFilePath = questionFilePath
        @accessFilePath = accessFilePath
        self.fillMatrix
    end

    def mostAccessedDisciplines(lastHours = 24)
        filterQuestionsByDays((lastHours / 24))
    end

    def mostAccessedQuestions(timeRange = 'week')        
        days = case timeRange

        when 'week'
            7
        when 'month'
            30
        when 'year'
            365
        end     
        
        questionsWithTotalAccess = filterQuestionsByDays(days)
        
        return questionsWithTotalAccess.sort { |a,b| -(a["totalAccess"] <=> b["totalAccess"])}
    end

    private

    def filterQuestionsByDays(days)
        now = DateTime.now

        result = @questions.filter_map do |questionItem|
            questionItem["totalAccess"] = questionItem["access"].reduce(0) do |sum,hash|
                if ( (now - hash["date"]) <= days )
                    sum + hash["times_accessed"]
                else
                    0
                end
            end
            if questionItem["totalAccess"] > 0 then questionItem end
        end

        return result
    end

    def fillMatrix()
        questions = self.fetchJson(@questionFilePath)
        access = self.fetchJson(@accessFilePath)
        @questions = questions.map do |questionItem|
            questionItem["access"] = access.filter_map do |accessItem|
                if(accessItem["question_id"] == questionItem["id"])
                    {"date"=>DateTime.parse(accessItem["date"]), "times_accessed"=>accessItem["times_accessed"]}
                end
            end
            questionItem
        end
    end

end