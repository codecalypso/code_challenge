require "../data/../learningpath"


describe "LearningPath" do
   let(:scores) { "../data/student_tests.csv" }
   let(:domains) { "../data/domain_order.csv" }
   let(:lp){ LearningPath.new }
   let(:paths){lp.compute_path(scores,domains)}


   it "determines students learning path" do
     expect(paths[0]).to eq({"Albin Stanton" =>["K.RI","1.RI","2.RF","2.RI","3.RF"]})
     expect(paths[1]).to eq({"Erik Purdy"=>["1.RL","1.RI","2.RI","2.RL","2.L"]})
     expect(paths[2]).to eq({"Aimee Cole"=>["K.RF","K.RL","1.RF","1.RL","1.RI"]})
   end

   it "ensures student doesn't repeat content that they have already mastered." do

   end

   it "contains up to five units" do

   end

   it "contains fewer than five units" do

   end

   it "creates path when student has no scores" do

   end

   it "is domain agnostic" do
   end
end
