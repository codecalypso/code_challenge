require_relative './learningpath'

class LearningPathDisplay
  def diplay_menu
  end

  def choices
    #select a student
    #select all students
  end

  def select_student
  end

  def print_students
    scores.each do |path|
      path.each do |k,v|
        print "#{k.colorize(:blue)}, #{v.join(',')}\n"
      end
    end
  end
end
