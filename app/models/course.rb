class Course < ApplicationRecord
  # Validations
  validates :code, uniqueness: true, presence: true
  validates :title, presence: true
  # Associations
  has_many :user_courses
  has_many :users, through: :user_courses
  has_many :comments, inverse_of: :course
  has_many :ratings

  def self.update_db(code, title, description, prerequisites, exclusions, breadths)
    breadth_num_to_val = Hash[1 => "Creative and Cultural Representations",
      2 => "Thought, Belief, and Behaviour",
      3 => "Society and Its Institutions",
      4 => "Living Things and Their Environment",
      5 => "The Physical and Mathematical Universes"]
      breadth_string = ""
      breadths.each do |breadth_num|
        breadth_string << breadth_num_to_val[breadth_num] + ";"
      end

      if Course.exists?(:code => code)
        course = Course.where(code: code)
        course.update(title: title, description: description,
          prerequisites: prerequisites, exclusions: exclusions,
          breadths: breadth_string)
      else
        course = Course.new(code: code, title: title, description: description,
          prerequisites: prerequisites, exclusions: exclusions,
          breadths: breadth_string)
        course.save
      end
    end
  end
