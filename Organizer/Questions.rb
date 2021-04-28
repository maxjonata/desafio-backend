require_relative './FileUser.rb'
require 'date'
require 'daru'

class Questions
    attr_reader :questions
    include FileUser

    def initialize(questionFilePath, accessFilePath)
        @questionFilePath = questionFilePath
        @accessFilePath = accessFilePath
        self.fillMatrix
    end

    def mostAccessedDisciplines(lastHours = 24)
        disciplineOrder = []

        filterQuestionsBySeconds((lastHours * 3600)).each do | question |
            disciplineHash = {}
            found = if disciplineHash.include?(question["discipline"]) then true else false end

            if found
                disciplineOrder[disciplineHash[question["discipline"]]]["totalAccess"] += question["totalAccess"]
            else
                disciplineHash[question["discipline"]] = disciplineOrder.length
                disciplineOrder.append({ "discipline" => question["discipline"], "totalAccess" => question["totalAccess"] })
            end
        end

        return disciplineOrder.sort { |a,b| -(a["totalAccess"] <=> b["totalAccess"])}
    end

    def mostAccessedQuestions(timeRange = 'week')
        daysInSeconds = case timeRange

        when 'week'
            7 * 86400
        when 'month'
            30 * 86400
        when 'year'
            365 * 86400
        end     
        
        questionsWithTotalAccess = filterQuestionsBySeconds(daysInSeconds)
        
        return questionsWithTotalAccess.sort { |a,b| -(a["totalAccess"] <=> b["totalAccess"])}
    end

    private

    def filterQuestionsBySeconds(seconds)
        now = Time.now

        result = @questions.filter_map do |questionItem|
            questionItem["totalAccess"] = questionItem["access"].reduce(0) do |sum,hash|
                if ( (now - hash["date"]) <= seconds )
                    (sum + hash["times_accessed"])
                else
                    sum
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
                    {"date"=>Time.parse(accessItem["date"]), "times_accessed"=>accessItem["times_accessed"]}
                end
            end
            questionItem
        end
    end

end