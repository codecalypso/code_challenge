require 'csv'
require_relative 'scoreparser'
require_relative 'domainparser'

class LearningPath
  attr_accessor :domains, :paths

  def initialize
    @paths = []
  end

  def compute_path(student_file,domain_file)
    domain_order = DomainParser.new(domain_file).domains
    ScoreParser.new(student_file).scores.each{|v| create_path(v,domain_order)}
    paths
  end


  def create_path(tests,domain)
    hash={}
    array = []
    domain.each do |domain_k,domain_v|
      format_input(domain_k)
      domain_v.each_with_index.each do |dv,i|
        tests.each do |score|
          score.each do |score_k,score_v|
            @name = score_v if score_k == "Student Name"
            format_input(score_v)
            if domain_v.at(i) == score_k && score_v.to_i <= domain_k.to_i
              array << format_output(domain_k,domain_v.at(i))
              hash[@name] = array.take(5)
            end
          end
        end
      end
    end
    paths<<hash
  end

  def format_input(grade)
    grade = 0 if grade == "K"
  end

  def format_output(grade,domain)
    if grade == "0".to_i
      grade = "K"
    end
    "#{grade}.#{domain}"
  end
end
