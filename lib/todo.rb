require 'csv'

class Todo

  def initialize(file_name)
    @file_name = file_name
    # You will need to read from your CSV here and assign them to the @todos variable. make sure headers are set to true
    @todos = CSV.read(@file_name, headers: true)
  end

  def start
    loop do
      system('clear')

      puts "---- TODO.rb ----"

      view_todos

      puts
      puts "What would you like to do?"
      puts "1) Exit 2) Add Todo 3) Mark Todo As Complete"
      print " > "
      action = gets.chomp.to_i
      case action
      when 1 then exit
      when 2 then add_todo
      when 3 then mark_todo
      else
        puts "\a"
        puts "Not a valid choice"
      end
    end
  end

  def todos
    @todos
  end

  def view_todos
    puts "Unfinished"
    puts unfinished
    puts "Completed"
    puts completed
  end

  def unfinished
    unfinished_todos = @todos.select { |row| row["completed"] == "no"}
    unfinished_todos.each_with_index.map { |row, index| "#{index + 1}) #{row[0]}" }
  end

  def completed
    completed_todos = @todos.select { |row| row["completed"] == "yes"}
    completed_todos.each_with_index.map { |row, index| "#{index + 1}) #{row[0]}" }
  end

  def add_todo
    puts "Name of Todo > "
    new_todo = get_input
    @todos << [new_todo, "no"]
    save!
  end

  def mark_todo
    puts "Which todo have you finished?"
    todo_index = get_input.to_i
    unfinished_index = 0
    @todos.each_with_index do |row, index|
      if row["completed"] == "no"
        unfinished_index += 1
        if unfinished_index == todo_index
          @todos[index]["completed"] = "yes"
        end
      end
    end
  end

  private
  def get_input
    gets.chomp
  end

  def save!
    File.write(@file_name, @todos.to_csv)
  end
end

Todo.new('../spec/test_todos.csv').start
