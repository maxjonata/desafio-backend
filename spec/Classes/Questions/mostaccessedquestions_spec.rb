require './Organizer/Questions'
require 'json'
require 'time'

describe Questions do
    describe "Methods" do

        before do
            DateOrder = [
                [true, true, false, true, true, false],
                [true, false, true, true, false, true],
                [false, true, true, false, true, true]
            ]

            QuestionFile = File.read('./spec/Classes/Questions/question_test.json')
            QuestionsJsonHash = JSON.parse(QuestionFile)

            ids = QuestionsJsonHash.map { | hash | hash["id"] }
            access = []
            for i1 in 0..2
                for i2 in 0..5
                    access.append({
                        "question_id": ids[i1],
                        "date": case i2
                            when 0
                                if DateOrder[i1][i2] then (Time.now() - (0.5 * 86400)) else (Time.now() - (1000 * 86400)) end
                            when 1
                                if DateOrder[i1][i2] then (Time.now() - (15 * 86400)) else (Time.now() - (1000 * 86400)) end
                            when 2
                                if DateOrder[i1][i2] then (Time.now() - (100 * 86400)) else (Time.now() - (1000 * 86400)) end
                            when 3
                                if DateOrder[i1][i2] then (Time.now() - (0.5 * 3600)) else (Time.now() - (1000 * 86400)) end
                            when 4
                                if DateOrder[i1][i2] then (Time.now() - (6 * 3600)) else (Time.now() - (1000 * 86400)) end
                            when 5
                                if DateOrder[i1][i2] then (Time.now() - (13 * 3600)) else (Time.now() - (1000 * 86400)) end
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

        describe "#mostAccessedQuestions" do

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

        describe "#mostAccessedDisciplines" do

            it "Get disciplines by 1 hour total access in descendant order" do
                test = @QuestionObj.mostAccessedDisciplines(1).map { |hash| hash["totalAccess"]}
                p test
                expect(test).to eq(test.sort.reverse)
            end

            it "Get disciplines by 12 hours total access in descendant order" do
                test = @QuestionObj.mostAccessedDisciplines(12).map { |hash| hash["totalAccess"]}
                p test
                expect(test).to eq(test.sort.reverse)
            end

            it "Get disciplines by 24 hours total access in descendant order" do
                test = @QuestionObj.mostAccessedDisciplines(24).map { |hash| hash["totalAccess"]}
                p test
                expect(test).to eq(test.sort.reverse)
            end

        end
        
    end
end