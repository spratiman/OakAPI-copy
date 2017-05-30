class Course < ApplicationRecord
  # Validations
  validates :code, uniqueness: true, presence: true
  validates :title, presence: true
  # Associations
  has_many :user_courses
  has_many :users, through: :user_courses
  has_many :comments, inverse_of: :course
  has_many :ratings

  def self.update_db(input)
    breadth_num_to_val = Hash[1 => "Creative and Cultural Representations",
      2 => "Thought, Belief, and Behaviour",
      3 => "Society and Its Institutions",
      4 => "Living Things and Their Environment",
      5 => "The Physical and Mathematical Universes"]
      breadth_string = ""
      input["breadths"].each do |breadth_num|
        breadth_string << breadth_num_to_val[breadth_num] + ";"
      end

      if Course.exists?(:code => input["code"])
        course = Course.where(code: input["code"])
        course.update(title:          input["name"],
                      description:    input["description"],
                      prerequisites:  input["prerequisites"],
                      exclusions:     input["exclusions"],
                      breadths:       breadth_string,
                      department:     input["department"],
                      division:       input["division"],
                      level:          input["level"],
                      campus:         input["campus"])
      else
        course = Course.new(code:           input["code"],
                            title:          input["name"],
                            description:    input["description"],
                            prerequisites:  input["prerequisites"],
                            exclusions:     input["exclusions"],
                            breadths:       breadth_string,
                            department:     input["department"],
                            division:       input["division"],
                            level:          input["level"],
                            campus:         input["campus"])
        course.save
      end
    end
  end
