class ScoreParser
  attr_accessor :scores

  def initialize(file)
    @file = file
    @scores = []
    parse_scores
  end

  private
  def parse_scores
    data =  File.read(@file)
    csv = CSV.parse(data, :headers => true)
    csv.map do |row|
      @scores << [row.to_h]
    end
    @scores
  end
end
