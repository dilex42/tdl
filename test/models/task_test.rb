require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "should not save task without text" do
    task = Task.new
    assert_not task.save, "Saved the task without a text"
  end

  test "should not save task without project" do
    task = Task.new
    task.text = 'test'
    assert_not task.save, "Saved the task without a project"
  end
end
