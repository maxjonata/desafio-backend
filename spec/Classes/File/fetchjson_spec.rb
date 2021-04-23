require './Organizer/FileUser'

class Mock
    include FileUser
end

describe File do
    describe "#FetchJson" do

        before do

            @FileObj = Mock.new()
            @jsonExpected = { "test" => 'test' }
            @test = @FileObj.fetchJson('./spec/Classes/File/test.json')

        end

        describe "FileUser" do

            it "Json File Fetch gets same keys" do
                expect(@test.keys).to eq(@jsonExpected.keys)
            end

            it "Json File Fetch gets same vales" do
                expect(@test.values).to eq(@jsonExpected.values)
            end

        end
        
    end
end