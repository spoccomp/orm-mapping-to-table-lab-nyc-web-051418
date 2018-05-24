
require 'pry'
class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(id = nil, name, grade)
    @id = id
    @name = name
    @grade = grade


  end
  #Class method
  def self.create_table
      #heredoc
    sql = <<-SQL
          CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
        SQL
    DB[:conn].execute(sql)
    #binding.pry
  end
  #Class method
  def self.drop_table#DROP TABLE table_name;
    sql = <<-SQL
          DROP TABLE students
        SQL
    DB[:conn].execute(sql)
  end
  #instance method
  def save#the ? question marks ard bound paremeters for security
    sql = <<-SQL
              INSERT INTO students (name, grade)
              VALUES (?, ?)
              SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]

  end
  #instance method
  def self.create (name:, grade:)
    student = Student.new(name, grade)
    student.save
    student

  end
  def find_me
    sql = <<-SQL
              SELECT * FROM students
              SQL
    DB[:conn].execute(sql)
  end
end
