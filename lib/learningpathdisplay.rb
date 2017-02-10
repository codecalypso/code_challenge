require_relative './learningpath'
require 'csv'

class LearningPathDisplay

  def initialize
    display_header
    process_input
  end

  def load
    learning_path=LearningPath.new
    parsed_scores=ScoreParser.new("../data/student_tests.csv").scores
    parsed_domains=DomainParser.new("../data/domain_order.csv").domains
    learning_path.create_path(parsed_scores,parsed_domains)
    @path=learning_path.paths
  end

  OPT_MAP = {
    "all"      => "print_students",
    "find"     => "select_student",
    "export "  => "export_results",
    "exit"     => "exit_program",
    "else"     => "display_menu"
  }

  def process_input
    selection = gets.chomp
    action = OPT_MAP.fetch(selection, :display_menu)
    send(action, param)
    process_input
  end

  def display_header
    puts "       Learning Pathway for Students            ".colorize(:black)
    puts "************************************************".colorize(:blue)
    puts "View learning plan based on a student's scores".colorize(:black)
    display_menu
  end

  def display_menu
    puts " "
    options = <<-HEREDOC
      VALID CHOICES: All | Find | Export | Exit

      All:    Prints  results for all students
      Find:   Find results for a student by name
      Export: Exports all students' results to CSV
      Exit:   Exits the program

    HEREDOC
    puts options
  end

  def print_students
    student_list
    load
    @path.each do |path|
      path.each do |k,v|
        puts "#{k.colorize(:blue)}".ljust(40) + "#{v.join(', ')}"
        puts "\n"
      end
    end
  end

  def student_list
    header= <<-HEREDOC
     -----------------------------
        Students' Scores
     ______________________________
    HEREDOC
    puts header
  end

  def select_student(name)
    load
    @path.map do |student|
      student.select do |k,v|
        k == name
      end
    end
  end

  def export_results
    load
    @path.each do |path|
      path.each do |k,v|
        CSV.open("learning_path.csv","wb") do |csv|
          csv<<[k,v]
        end
      end
    end
  end

  def exit_program
    puts "Thank you for using the service...goodbye :)"
    exit
  end
  LearningPathDisplay.new
end
