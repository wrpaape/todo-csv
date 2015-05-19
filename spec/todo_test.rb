require 'test/unit'
require_relative '../lib/todo'


module Kernel
  # For testing purposes. Never do this
  def print(msg)
    $output << msg
  end
  def puts(msg = '')
    $output << msg
  end
  # Oh god never do this
  def gets
    Struct.new(:chomp).new
  end
end

# Overriding Todo methods for easier testing
class Todo
  def get_input
    ($input ||= []).last #Use our global input instead of asking for actual user input
  end
  def save!
    nil # Don't change our test file
  end
end
# Dont touch ^^^

class TodoTest < Test::Unit::TestCase

  def todo_setup
    $input, $output = [] # Reset all messages between tests
    @todo = Todo.new('test_todos.csv') # Given
  end

  def test_view_todos_prints_unfinished_header
    todo_setup # Given
    @todo.view_todos # When
    assert($output.include?("Unfinished")) # Then
  end

  # ============
  # ==============================================================
  # -- UNCOMMENT EACH TEST WHEN YOU GET THE ONE BEFORE IT TO PASS
  # ==============================================================
  # ============

  #def test_view_todos_prints_completed_header
  #  todo_setup # Given
  #  @todo.view_todos # When
  #  assert($output.include?("Completed")) # Then
  #end

  #def test_view_todos_prints_todos
  #  todo_setup # Given
  #  assert_equal("1) finish homework", $output[1]) # Then
  #end

  #def test_add_todo_prints_prompt
  #  todo_setup # Given
  #  @todo.add_todo
  #  assert_equal("Name of Todo > ", $output.last)
  #end

  #def test_add_todo_creates_new_todo
  #  todo_setup # Given
  #  $input.push("make this test pass") # So we can test input (can't use gets in a test)
  #  @todo.add_todo
  #  assert_equal("make this test pass,no\n", @todo.todos[1].to_s)
  #end

  #def test_mark_todo_prints_prompt
  #  todo_setup # Given
  #  @todo.mark_todo
  #  assert_equal("Which todo have you finished?", $output.last)
  #end

  #def test_mark_todo_changes_todo
  #  todo_setup # Given
  #  $input.push('1')
  #  @todo.mark_todo
  #  assert_equal("finish homework,yes\n", @todo.todos[0].to_s)
  #end
end
