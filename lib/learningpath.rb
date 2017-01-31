require 'csv'
require_relative 'scoreparser'
require_relative 'domainparser'

class LearningPath
  attr_accessor :domains, :paths

  def initialize
    @paths = []
  end
  parsed_scores=ScoreParser.new('./data/student_tests.csv').scores
  parsed_domains=DomainParser.new('./data/domain_order.csv').domains

  def create_path(parsed_scores,parsed_domains)
    hash={}
    array=[]
    path=[]
    parsed_scores.map do |score|
      score.inject(0) do|memo,score_unit|
        parsed_domains.map do |domain_k,domain_v|
          domain_v.each_with_index do |dv,i|
            score_unit.each do |score_k,score_v|
              @name = score_v if score_k == "Student Name"
              if domain_v.at(i) == score_k && score_v.to_i <= domain_k.to_i
                memo+=1
                @new_array = Array.new if memo == 1
                if memo<=5
                  @new_array << format_output(domain_k,domain_v.at(i))
                end
                hash[@name]=@new_array
              elsif score_unit.keys.size == 1
                  memo+=1
                  @new_array = Array.new if memo == 1
                  if memo<=5
                    @new_array << format_output(domain_k,domain_v.at(i))
                  end
                  hash[@name]=@new_array
              end
            end
          end
        end
      end
    end
    paths<<hash
 end

  def format_output(grade,domain)
    "#{grade}.#{domain}"
  end
end
