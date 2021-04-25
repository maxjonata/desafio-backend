require './Organizer/Questions'
require 'json'

describe Questions do
    describe "#mostAccessedQuestions" do

        before do
            DateOrder = [
                [true, true, false],
                [true, false, true],
                [false, true, true]
            ]

            QuestionFile = File.read('./spec/Classes/Questions/question_test.json')
            QuestionsJsonHash = JSON.parse(QuestionFile)

            ids = QuestionsJsonHash.map { | hash | hash["id"] }
            access = []
            for i1 in 0..2
                for i2 in 0..2
                    access.append({
                        "question_id": ids[i1],
                        "date": case i2
                            when 0
                                if DateOrder[i1][i2] then (DateTime.now() - 2) else (DateTime.now() - 1000) end
                            when 1
                                if DateOrder[i1][i2] then (DateTime.now() - 15) else (DateTime.now() - 1000) end
                            when 2
                                if DateOrder[i1][i2] then (DateTime.now() - 100) else (DateTime.now() - 1000) end
                            end,
                        "times_accessed": rand(10000)
                    })
                end
            end

            File.open('./spec/Classes/Questions/access_test.json', 'w') do | f |
                f.write(access.to_json)
            end

            @QuestionObj = Questions.new('./spec/Classes/Questions/question_test.json', './spec/Classes/Questions/access_test.json')

        end

        describe "Questions" do

            it "Get questions by week total access in descendant order" do
                test = @QuestionObj.mostAccessedQuestions('week').map { |hash| hash["totalAccess"]}
                expect(test).to eq(test.sort.reverse)
            end

            it "Get questions by month total access in descendant order" do
                test = @QuestionObj.mostAccessedQuestions('month').map { |hash| hash["totalAccess"]}
                expect(test).to eq(test.sort.reverse)
            end

            it "Get questions by year total access in descendant order" do
                test = @QuestionObj.mostAccessedQuestions('year').map { |hash| hash["totalAccess"]}
                expect(test).to eq(test.sort.reverse)
            end

        end
        
    end
end