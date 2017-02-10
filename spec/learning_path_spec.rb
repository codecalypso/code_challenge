require 'csv'
require_relative "../lib/learningpath"
require_relative "../lib/scoreparser"
require_relative "../lib/domainparser"

describe "LearningPath" do

   parsed_domains = {"K"=>["RF", "RL", "RI"],
                     "1"=>["RF", "RL", "RI"],
                     "2"=>["RF", "RI", "RL", "L"],
                     "3"=>["RF", "RL", "RI", "L"],
                     "4"=>["RI", "RL", "L"],
                     "5"=>["RI", "RL", "L"],
                     "6"=>["RI", "RL"]
                    }
    let(:path){LearningPath.new}
    let(:student1){[[{"Student Name"=>"Albin Stanton", "RF"=>"2", "RL"=>"3", "RI"=>"K", "L"=>"3"}]]}
    let(:student2){[[{"Student Name"=>"Peter Parker", "RF"=>"3","RL"=>"6","RI"=>"6","L"=>"5"}]]}
    let(:student3){[[{"Student Name"=>"Bruce Wayne"}]]}
    let(:student4){[[{"Student Name"=>"Ayana Runolfsson", "RF"=>"K", "RL"=>"2", "RI"=>"5","L"=>"2"}]]}

    let(:parsed_scores){ScoreParser.new("./spec/fixtures/student_math_scores.csv").scores}
    let(:parsed_domain){DomainParser.new("./spec/fixtures/math_domain.csv").domains}
    let(:alternate_domain){path.create_path(parsed_scores,parsed_domain)}



   it "determines student's learning path" do
     expect(path.create_path(student1,parsed_domains)).to include({"Albin Stanton"=>["K.RI", "1.RI", "2.RF", "2.RI", "3.RF"]})
   end

   it "ensures student doesn't repeat content that they have already mastered." do
     expect(path.create_path(student4,parsed_domains)[0]["Ayana Runolfsson"]).to_not include("1.RL")
   end

   it "contains up to five units" do
     expect(path.create_path(student1,parsed_domains)[0]["Albin Stanton"].size).to eq(5)
   end

   it "contains fewer than five units" do
     expect(path.create_path(student2,parsed_domains)[0]["Peter Parker"].size).to eq(4)
   end

   it "creates path when student has no scores" do
     expect(path.create_path(student3,parsed_domains)).to include({"Bruce Wayne"=>["K.RF","K.RL","K.RI","1.RF","1.RL"]})
   end

   it "is domain agnostic" do
     expect(alternate_domain.any? {|hash| hash["Addie Green"] == ["1.ML","2.AD","2.ML","2.DV","2.GM"]}).to be_truthy
   end
end
