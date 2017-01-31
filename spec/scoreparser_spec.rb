require "csv"
require_relative "../lib/scoreparser"

describe "ScoreParser#initialize" do

  parser = ScoreParser.new("./data/student_tests.csv")

  it "loads students scores" do
    expect(parser.scores.size).to eq(30)
  end
end
